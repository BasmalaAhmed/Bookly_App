import 'package:bookly_app/features/auth/data/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    final auth = FirebaseAuth.instance;
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
    required String email,
    required String password,
  }) async {
    final auth = FirebaseAuth.instance;
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user?.sendEmailVerification();
    await auth.signOut();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    final auth = FirebaseAuth.instance;
    await auth.sendPasswordResetEmail(email: email);
  }
}
