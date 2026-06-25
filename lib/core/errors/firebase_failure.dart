import 'package:bookly_app/core/errors/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFailure extends Failure {
  const FirebaseFailure(super.message);
  factory FirebaseFailure.fromFirebaseAuthException(FirebaseAuthException ex) {
    switch (ex.code) {
      case 'weak-password':
        return FirebaseFailure('Weak Password!');

      case 'email-already-in-use':
        return FirebaseFailure('Email already exists!');

      case 'user-not-found':
        return FirebaseFailure('No user found matching this email!');

      case 'wrong-password':
      case 'invalid-credential':
        return FirebaseFailure('Email or password is incorrect!');

      case 'invalid-email':
        return FirebaseFailure('Invalid email address!');

      default:
        return FirebaseFailure(ex.message ?? 'Authentication failed!');
    }
  }
}
