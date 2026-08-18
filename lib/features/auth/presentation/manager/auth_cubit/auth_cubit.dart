import 'package:bloc/bloc.dart';
import 'package:bookly_app/core/errors/firebase_failure.dart';
import 'package:bookly_app/features/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:bookly_app/features/auth/data/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await authRepo.registerUser(email: email, password: password, name: name);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      emit(
        AuthFailure(FirebaseFailure.fromFirebaseAuthException(ex).errMessage),
      );
    } catch (e) {
      emit(AuthFailure("Something went wrong!"));
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await authRepo.loginUser(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'invalid-credential') {
        final pendingEmail = await authRepo.getPendingEmail();

        if (email.trim() == pendingEmail) {
          emit(
            AuthFailure(
              'Please verify your new email before logging in.',
            ),
          );
          return;
        }
      }
      emit(
        AuthFailure(FirebaseFailure.fromFirebaseAuthException(ex).errMessage),
      );
    } catch (e) {
      emit(AuthFailure("Something went wrong!"));
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await authRepo.resetPassword(email: email);
      emit(ResetPasswordSuccess());
    } on FirebaseAuthException catch (ex) {
      emit(
        AuthFailure(FirebaseFailure.fromFirebaseAuthException(ex).errMessage),
      );
    } catch (e) {
      emit(AuthFailure("Something went wrong!"));
    }
  }

  Future<void> changeEmail({
    required String newEmail,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await authRepo.changeEmail(newEmail: newEmail, password: password);
      emit(ChangeEmailSuccess());
    } on FirebaseAuthException catch (ex) {
      emit(
        AuthFailure(FirebaseFailure.fromFirebaseAuthException(ex).errMessage),
      );
    } catch (e) {
      emit(AuthFailure('Something went wrong!'));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      await authRepo.logout();
      emit(LogoutSuccess());
    } on FirebaseAuthException catch (ex) {
      emit(
        AuthFailure(FirebaseFailure.fromFirebaseAuthException(ex).errMessage),
      );
    } catch (e) {
      emit(AuthFailure('Something went wrong!'));
    }
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());

    try {
      final isLoggedIn = await authRepo.isUserLoggedIn();
      if (isLoggedIn) {
        emit(LoginSuccess());
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthFailure('Something went wrong!'));
    }
  }
}
