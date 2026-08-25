import 'package:bookly_app/features/notifications/data/models/notification_model.dart';
import 'package:bookly_app/features/notifications/data/repos/notification_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationRepoImpl implements NotificationRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  NotificationRepoImpl({required this.firestore, required this.auth});

  CollectionReference<Map<String, dynamic>> get _notificationsCollection {
    final user = auth.currentUser;

    if (user == null) {
      throw FirebaseException(
        plugin: 'firebase_auth',
        code: 'user-not-authenticated',
      );
    }
    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('notifications');
  }

  DocumentReference<Map<String, dynamic>> get _userDocument {
    final user = auth.currentUser;

    if (user == null) {
      throw FirebaseException(
        plugin: 'firebase_auth',
        code: 'user-not-authenticated',
      );
    }

    return firestore.collection('users').doc(user.uid);
  }

  @override
  Future<bool> getNotificationsEnabled() async {
    final snapshot = await _userDocument.get();
    return snapshot.data()?['notificationsEnabled'] ?? true;
  }

  @override
  Future<void> setNotificationsEnabled(bool enabled) async {
    await _userDocument.set({
      'notificationsEnabled': enabled,
    }, SetOptions(merge: true));
  }

  @override
  Future<List<NotificationModel>> fetchNotifications() async {
    final snapshot = await _notificationsCollection
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => NotificationModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  @override
  Future<void> createNotification(NotificationModel notification) async {
    await _notificationsCollection
        .doc(notification.id)
        .set(notification.toMap());
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _notificationsCollection.doc(notificationId).update({'isRead': true});
  }

  @override
  Future<void> markAllAsRead() async {
    final snapshot = await _notificationsCollection
        .where('isRead', isEqualTo: false)
        .get();
    final batch = firestore.batch();
    for (final doc in snapshot.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await _notificationsCollection.doc(notificationId).delete();
  }

  @override
  Future<void> saveFcmToken(String token) async {
    await _userDocument.set({
      'fcmToken' : token,
    }, SetOptions(merge: true),);
  }
}
