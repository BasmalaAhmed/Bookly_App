import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/notifications/data/models/notification_model.dart';
import 'package:bookly_app/features/notifications/data/repos/notification_repo.dart';
import 'package:bookly_app/features/notifications/presentation/manager/notification_cubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo notificationRepo;
  NotificationCubit(this.notificationRepo) : super(NotificationInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationLoading());

    try {
      final notifications = await notificationRepo.fetchNotifications();

      emit(NotificationSuccess(notifications));
    } catch (e) {
      emit(NotificationFailure('Something went wrong. Please try again.'));
    }
  }

  Future<void> createNotification(NotificationModel notification) async {
    try {
      await notificationRepo.createNotification(notification);
      await fetchNotifications();
    } catch (e) {
      emit(NotificationFailure('Failed to create notification.'));
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await notificationRepo.markAsRead(notificationId);

      await fetchNotifications();
    } catch (e) {
      emit(NotificationFailure('Failed to update notification.'));
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await notificationRepo.markAllAsRead();

      await fetchNotifications();
    } catch (e) {
      emit(NotificationFailure('Failed to update notification.'));
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await notificationRepo.deleteNotification(notificationId);

      await fetchNotifications();
    } catch (e) {
      emit(NotificationFailure('Failed to delete notification.'));
    }
  }
}
