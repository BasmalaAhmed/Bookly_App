import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/notifications/data/repos/notification_repo.dart';
import 'package:bookly_app/features/notifications/presentation/manager/notification_settings_cubit/notification_settings_state.dart';

class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  final NotificationRepo notificationRepo;
  NotificationSettingsCubit(this.notificationRepo)
    : super(NotificationSettingsInitial());

  Future<void> getNotificationsEnabled() async {
    emit(NotificationSettingLoading());

    try {
      final isEnabled = await notificationRepo.getNotificationsEnabled();
      emit(NotificationSettingSuccess(isEnabled));
    } catch (e) {
      emit(NotificationSettingFailure('Failed to load notification settings.'));
    }
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    try {
      await notificationRepo.setNotificationsEnabled(enabled);

      emit(NotificationSettingSuccess(enabled));
    } catch (e) {
      emit(
        NotificationSettingFailure('Failed to update notification settings.'),
      );
    }
  }
}
