import 'package:bookly_app/features/auth/data/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    final userCredential =
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if(user != null && !user.emailVerified){
      await FirebaseAuth.instance.signOut();
      throw FirebaseAuthException(code: 'email-not-verified', message: 'Please verify your email before logging in.');
    }
  }

  @override
  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user?.sendEmailVerification();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
