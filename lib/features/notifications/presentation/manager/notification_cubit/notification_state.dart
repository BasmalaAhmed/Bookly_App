import 'package:bookly_app/features/notifications/data/models/notification_model.dart';

sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;

  final int unreadCount;

  NotificationSuccess(this.notifications)
    : unreadCount = notifications
          .where((notification) => !notification.isRead)
          .length;
}

final class NotificationFailure extends NotificationState {
  final String errMessage;

  NotificationFailure(this.errMessage);
}
