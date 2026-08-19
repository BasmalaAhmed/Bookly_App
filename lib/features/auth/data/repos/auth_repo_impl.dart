import 'package:bookly_app/features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/features/favorites/data/repos/favorite_repo.dart';
import 'package:bookly_app/features/profile/data/repos/profile_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepoImpl implements AuthRepo {
  final ProfileRepo profileRepo;
  final FirebaseAuth auth;
  final SharedPreferences prefs;
  final FavoriteRepo favoriteRepo;

  AuthRepoImpl({
    required this.profileRepo,
    required this.auth,
    required this.prefs,
    required this.favoriteRepo,
  });
  @override
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    final pendingEmail = await getPendingEmail();

    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user?.reload();

    final user = userCredential.user;

    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'User not found.',
      );
    }

    if (!user.emailVerified) {
      await auth.signOut();
      if (email == pendingEmail) {
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Please verify your email before logging in.',
        );
      }

      throw FirebaseAuthException(
        code: 'email-not-verified',
        message: 'Please verify your email before logging in.',
      );
    }

    if (email == pendingEmail) {
      await clearPendingEmail();
    }

    if (!(userCredential.user?.emailVerified ?? false)) {
      await auth.signOut();
      throw FirebaseAuthException(
        code: 'email-not-verified',
        message: 'Please verify your email before logging in.',
      );
    }
  }

  @override
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-creation-failed',
        message: 'Failed to create user.',
      );
    }

    await profileRepo.createProfile(uid: user.uid, name: name);

    await user.sendEmailVerification();
    await auth.signOut();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<String?> getCurrentUserEmail() async {
    await auth.currentUser?.reload();
    return auth.currentUser?.email;
  }

  @override
  Future<void> changeEmail({
    required String newEmail,
    required String password,
  }) async {
    final user = auth.currentUser;

    if (user == null || user.email == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No authenticated user found.',
      );
    }
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );

    await user.reauthenticateWithCredential(credential);

    await user.verifyBeforeUpdateEmail(newEmail);

    await savePendingEmail(newEmail);
  }

  static const String _pendingEmailKey = 'pending_email';

  @override
  Future<void> savePendingEmail(String email) async {
    await prefs.setString(_pendingEmailKey, email);
  }

  @override
  Future<String?> getPendingEmail() async {
    return prefs.getString(_pendingEmailKey);
  }

  @override
  Future<void> clearPendingEmail() async {
    await prefs.remove(_pendingEmailKey);
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = auth.currentUser;
    if (user == null || user.email == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No authenticated user found.',
      );
    }

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    await user.reauthenticateWithCredential(credential);

    await user.updatePassword(newPassword);
  }

  @override
  Future<void> deleteAccount({required String password}) async {
    final user = auth.currentUser;

    if (user == null || user.email == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No authenticated user found.',
      );
    }

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );
    await user.reauthenticateWithCredential(credential);

    await favoriteRepo.deleteAllFavorites();
    await profileRepo.deleteProfile(uid: user.uid);
    
    await user.delete();
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  Future<bool> isUserLoggedIn() async {
    await auth.currentUser?.reload();
    final user = auth.currentUser;

    return user != null && user.emailVerified;
  }
}
