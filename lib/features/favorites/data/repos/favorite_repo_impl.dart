import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/errors/firestore_failure.dart';
import 'package:bookly_app/features/favorites/data/repos/favorite_repo.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteRepoImpl implements FavoriteRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  FavoriteRepoImpl({required this.firestore, required this.auth});

  CollectionReference<Map<String, dynamic>> get _favoritesCollection {
    final user = auth.currentUser;

    if (user == null) {
      throw FirebaseException(
        plugin: 'firebase_auth',
        code: 'user-not-authenticated',
      );
    }
    return firestore.collection('users').doc(user.uid).collection('favorites');
  }

  @override
  Future<Either<Failure, void>> addFavorite(BookModel book) async {
    try {
      await _favoritesCollection.doc(book.id).set(book.toMap());
      return right(null);
    } on FirebaseException catch (e) {
      return left(FirestoreFailure.fromFirebaseException(e));
    } catch (e) {
      return left(FirestoreFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchFavorites() async {
    try {
      final snapshot = await _favoritesCollection.get();

      final books = snapshot.docs
          .map((doc) => BookModel.fromMap(doc.data()))
          .toList();

      return right(books);
    } on FirebaseException catch (e) {
      return left(FirestoreFailure.fromFirebaseException(e));
    } catch (e) {
      return left(FirestoreFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String id) async {
    try {
      final doc = await _favoritesCollection.doc(id).get();

      return right(doc.exists);
    } on FirebaseException catch (e) {
      return left(FirestoreFailure.fromFirebaseException(e));
    } catch (e) {
      return left(FirestoreFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String id) async {
    try {
      await _favoritesCollection.doc(id).delete();
      return right(null);
    } on FirebaseException catch (e) {
      return left(FirestoreFailure.fromFirebaseException(e));
    } catch (e) {
      return left(FirestoreFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<void> deleteAllFavorites() async {
    try {
      final snapshot = await _favoritesCollection.get();
      if (snapshot.docs.isEmpty) return;
      final batch = firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirestoreFailure.fromFirebaseException(e);
    } catch (e) {
      throw FirestoreFailure('Something went wrong. Please try again.');
    }
  }
}
