import 'package:bookly_app/features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/features/profile/data/repos/profile_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final ProfileRepo profileRepo;
  final FirebaseAuth auth;

  AuthRepoImpl({required this.profileRepo, required this.auth});
  @override
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user?.reload();
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
