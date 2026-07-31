import 'package:bookly_app/core/errors/failures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreFailure extends Failure {
  const FirestoreFailure(super.errMessage);

  factory FirestoreFailure.fromFirebaseException(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return const FirestoreFailure(
          'You do not have permission to perform this action.',
        );
      case 'unavailable':
        return const FirestoreFailure('Service is currently unavailable.');
      case 'deadline-exceeded':
        return const FirestoreFailure(
          'The request timed out. Please try again.',
        );
      default:
        return FirestoreFailure(e.message ?? 'Something went wrong.');
    }
  }
}
