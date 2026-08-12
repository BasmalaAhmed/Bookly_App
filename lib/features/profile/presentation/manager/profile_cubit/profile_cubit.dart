import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/profile/data/repos/profile_repo.dart';
import 'package:bookly_app/features/profile/presentation/manager/profile_cubit/profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  final FirebaseAuth auth;

  ProfileCubit({required this.profileRepo, required this.auth})
    : super(ProfileInitial());

  Future<void> fetchProfile() async {
    emit(ProfileLoading());

    try {
      final user = auth.currentUser;

      if (user == null) {
        emit(ProfileFailure('No authenticated user found.'));
        return;
      }

      final profile = await profileRepo.getProfile(uid: user.uid);

      emit(
        ProfileSuccess(
          name: profile['name'] ?? '',
          email: user.email ?? '',
          photoUrl: profile['photoUrl'],
        ),
      );
    } catch (e) {
      emit(ProfileFailure('Something went wrong!'));
    }
  }

  Future<void> updateProfile({required String name}) async {
    final currentState = state;

    if (currentState is! ProfileSuccess) return;

    emit(
      ProfileLoading(
        name: currentState.name,
        email: currentState.email,
        photoUrl: currentState.photoUrl,
      ),
    );

    try {
      final user = auth.currentUser;

      if (user == null) {
        emit(ProfileFailure('No authenticated user found.'));
        return;
      }

      await profileRepo.updateProfile(uid: user.uid, name: name);

      emit(
        ProfileSuccess(
          name: name,
          email: currentState.email,
          photoUrl: currentState.photoUrl,
        ),
      );
    } catch (e) {
      emit(ProfileFailure('Something went wrong!'));
    }
  }
}
