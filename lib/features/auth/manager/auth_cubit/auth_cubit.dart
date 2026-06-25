import 'package:bloc/bloc.dart';
import 'package:bookly_app/core/errors/firebase_failure.dart';
import 'package:bookly_app/features/auth/manager/auth_cubit/auth_state.dart';
import 'package:bookly_app/features/auth/data/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await authRepo.registerUser(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      emit(AuthFailure(FirebaseFailure.fromFirebaseAuthException(ex).message));
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
      print('Firebase Error Code: ${ex.code}');
      emit(AuthFailure(FirebaseFailure.fromFirebaseAuthException(ex).message));
    } catch (e) {
      emit(AuthFailure("Something went wrong!"));
    }
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    emit(AuthLoading());
    try {
      await authRepo.resetPassword(email: email);
      emit(ResetPasswordSuccess());
    } on FirebaseAuthException catch (ex) {
      emit(AuthFailure(FirebaseFailure.fromFirebaseAuthException(ex).message));
    } catch (e) {
      emit(AuthFailure("Something went wrong!"));
    }
  }
}
