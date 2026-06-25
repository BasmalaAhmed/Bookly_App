import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/auth/manager/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(AuthFailure("Weak Password!"));
      } else if (ex.code == 'email-already-in-use') {
        emit(AuthFailure("Email already exists!"));
      }
      else {
    emit(AuthFailure(ex.message ?? "Authentication failed!"));
  }
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(AuthFailure("No user found matching this email!"));
      } else if (ex.code == 'wrong-password' ||
          ex.code == 'invalid-credential') {
        emit(AuthFailure("Email or password is incorrect!"));
      }
      else {
    emit(AuthFailure(ex.message ?? "Authentication failed!"));
  }
    } catch (e) {
      emit(AuthFailure("Something went wrong!"));
    }
  }
}
