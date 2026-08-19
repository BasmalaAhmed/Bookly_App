import 'package:bloc/bloc.dart';
import 'package:bookly_app/core/errors/firebase_failure.dart';
import 'package:bookly_app/features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/features/settings/presentation/manager/change_password_cubit/change_password_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuthRepo authRepo;

  ChangePasswordCubit(this.authRepo) : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoading());

    try {
      await authRepo.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      await authRepo.logout();
      
      emit(ChangePasswordSuccess());
    } on FirebaseAuthException catch (ex) {
      emit(
        ChangePasswordFailure(
          FirebaseFailure.fromFirebaseAuthException(ex).errMessage,
        ),
      );
    } catch (e) {
      emit(ChangePasswordFailure('Something went wrong!'));
    }
  }
}
