import 'package:bookly_app/features/notifications/data/models/notification_model.dart';

abstract class NotificationRepo {

  Future<bool> getNotificationsEnabled();

  Future<void> setNotificationsEnabled(bool enabled);

  Future<List<NotificationModel>> fetchNotifications();

  Future<void> createNotification(NotificationModel notification);

  Future<void> markAsRead(String notificationId);

  Future<void> markAllAsRead();

  Future<void> deleteNotification(String notificationId);

  Future<void> deleteAllNotifications();

  Future<void> saveFcmToken(String token);

  Stream<List<NotificationModel>> watchNotifications();
}