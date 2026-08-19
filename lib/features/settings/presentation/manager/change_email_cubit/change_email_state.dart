sealed class ChangeEmailState {}

final class ChangeEmailInitial extends ChangeEmailState {}

final class ChangeEmailLoading extends ChangeEmailState {}

final class ChangeEmailSuccess extends ChangeEmailState {}

final class ChangeEmailFailure extends ChangeEmailState {
  final String errMessage;

  ChangeEmailFailure(this.errMessage);

}
