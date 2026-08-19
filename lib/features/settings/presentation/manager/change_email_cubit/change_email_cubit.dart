import 'package:bloc/bloc.dart';
import 'package:bookly_app/core/errors/firebase_failure.dart';
import 'package:bookly_app/features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/features/settings/presentation/manager/change_email_cubit/change_email_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangeEmailCubit extends Cubit<ChangeEmailState> {
  final AuthRepo authRepo;

  String? currentEmail;

  ChangeEmailCubit(this.authRepo) : super(ChangeEmailInitial()) {
    _getCurrentUserEmail();
  }

  Future<void> _getCurrentUserEmail() async {
    try {
      currentEmail = await authRepo.getCurrentUserEmail();
      emit(ChangeEmailInitial());
    } on FirebaseAuthException catch (ex) {
      emit(
        ChangeEmailFailure(
          FirebaseFailure.fromFirebaseAuthException(ex).errMessage,
        ),
      );
    } catch (e) {
      emit(ChangeEmailFailure('Something went wrong!'));
    }
  }

  Future<void> changeEmail({
    required String newEmail,
    required String password,
  }) async {
    emit(ChangeEmailLoading());

    try {
      await authRepo.changeEmail(newEmail: newEmail, password: password);
      emit(ChangeEmailSuccess());
    } on FirebaseAuthException catch (ex) {
      emit(
        ChangeEmailFailure(
          FirebaseFailure.fromFirebaseAuthException(ex).errMessage,
        ),
      );
    } catch (e) {
      emit(ChangeEmailFailure('Something went wrong!'));
    }
  }
}
