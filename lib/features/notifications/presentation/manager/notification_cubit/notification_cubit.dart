import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/notifications/data/models/notification_model.dart';
import 'package:bookly_app/features/notifications/data/repos/notification_repo.dart';
import 'package:bookly_app/features/notifications/presentation/manager/notification_cubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo notificationRepo;

  StreamSubscription<List<NotificationModel>>? _notificationsSubscription;
  NotificationCubit(this.notificationRepo) : super(NotificationInitial());

  void watchNotifications() {
    emit(NotificationLoading());

    _notificationsSubscription?.cancel();

    _notificationsSubscription = notificationRepo.watchNotifications().listen(
      (notifications) {
        emit(NotificationSuccess(notifications));
      },
      onError: (_) {
        emit(NotificationFailure('Something went wrong. Please try again.'));
      },
    );
  }

  @override
  Future<void> close() {
    _notificationsSubscription?.cancel();
    return super.close();
  }

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
    } catch (e) {
      emit(NotificationFailure('Failed to create notification.'));
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await notificationRepo.markAsRead(notificationId);

    } catch (e) {
      emit(NotificationFailure('Failed to update notification.'));
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await notificationRepo.markAllAsRead();

    } catch (e) {
      emit(NotificationFailure('Failed to update notification.'));
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await notificationRepo.deleteNotification(notificationId);

    } catch (e) {
      emit(NotificationFailure('Failed to delete notification.'));
    }
  }
}
