import 'package:bookly_app/features/profile/data/repos/profile_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepoImpl implements ProfileRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ProfileRepoImpl({required this.firestore, required this.auth});

  @override
  Future<void> createProfile({
    required String uid,
    required String name,
  }) async {
    await firestore.collection('users').doc(uid).set({
      'name': name,
      'photoUrl': null,
    });
  }

  @override
  Future<Map<String, dynamic>> getProfile({required String uid}) async {
    final docRef = firestore.collection('users').doc(uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      final data = {'name': '', 'photoUrl': null};
      await docRef.set(data);
      return data;
    }

    return doc.data()!;
  }

  @override
  Future<void> updateProfile({
    required String uid,
    required String name,
  }) async {
    await firestore.collection('users').doc(uid).update({'name': name});
  }

  @override
  Future<void> deleteProfile({required String uid}) async {
    final user = auth.currentUser;

    if (user == null) {
      throw FirebaseException(plugin: 'firebase_auth', code: 'user-not-found');
    }
    await firestore.collection('users').doc(uid).delete();
  }
}
