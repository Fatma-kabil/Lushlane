import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());

    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
       print('FirebaseAuthException: ${e.code}');
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errMassege: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(
            LoginFailure(errMassege: 'Wrong password provided for that user.'));
      }else if (e.code == 'invalid-email-format'|| e.code == 'invalid-email') {
        emit(LoginFailure(errMassege: 'Invalid email format'));
      }
    } on Exception {
      
      emit(LoginFailure(errMassege: 'Somthing went wrong'));
    }
  }
}
