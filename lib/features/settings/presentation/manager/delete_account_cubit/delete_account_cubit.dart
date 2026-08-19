import 'package:bloc/bloc.dart';
import 'package:bookly_app/core/errors/firebase_failure.dart';
import 'package:bookly_app/features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/features/settings/presentation/manager/delete_account_cubit/delete_account_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final AuthRepo authRepo;
  DeleteAccountCubit(this.authRepo) : super(DeleteAccountInitial());

  Future<void> deleteAccount({required String password}) async {
    emit(DeleteAccountLoading());

    try {
      await authRepo.deleteAccount(password: password);


      emit(DeleteAccountSuccess());
    } on FirebaseAuthException catch (ex) {
      emit(
        DeleteAccountFailure(
          FirebaseFailure.fromFirebaseAuthException(ex).errMessage,
        ),
      );
    } catch (e) {
      emit(DeleteAccountFailure('Something went wrong!'));
    }
  }
}
