abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {
  final String? name;
  final String? email;
  final String? photoUrl;

  ProfileLoading({this.name, this.email, this.photoUrl});
}

class ProfileSuccess extends ProfileState {
  final String name;
  final String email;
  final String? photoUrl;

  ProfileSuccess({required this.name, required this.email, this.photoUrl});
}

class ProfileFailure extends ProfileState {
  final String message;

  ProfileFailure(this.message);
}
