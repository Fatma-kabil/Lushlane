import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_states.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitial());

  Future<void> registerUser(
      {required String email, required String password,required String name}) async {
    emit(SignupLoading());

    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

          
    // هنا بنضيف الاسم كـ displayName في Firebase Auth
    await user.user!.updateDisplayName(name);

      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupFailure(errMassege: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupFailure(errMassege: 'email-already-in-use'));
      }
    } on Exception {
      emit(SignupFailure(errMassege: 'Somthing went wrong'));
    }
  }
}
