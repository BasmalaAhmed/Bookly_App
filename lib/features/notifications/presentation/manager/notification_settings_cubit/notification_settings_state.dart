sealed class NotificationSettingsState {}

final class NotificationSettingsInitial extends NotificationSettingsState {}

final class NotificationSettingLoading extends NotificationSettingsState {}

final class NotificationSettingSuccess extends NotificationSettingsState {
  final bool isEnabled;

  NotificationSettingSuccess(this.isEnabled);
}

final class NotificationSettingFailure extends NotificationSettingsState {
  final String errMessage;

  NotificationSettingFailure(this.errMessage);
}