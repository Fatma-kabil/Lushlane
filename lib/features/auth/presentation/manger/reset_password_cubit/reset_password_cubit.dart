import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

   Future<void> resetPassword({required String email}) async {
    emit(ResetPasswordLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ResetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      // تحسين الرسائل بناءً على كود الخطأ
      switch (e.code) {
        case 'user-not-found':
          emit(ResetPasswordFailure(errMassege: 'No user found for that email.'));
          break;
        case 'invalid-email':
          emit(ResetPasswordFailure(errMassege: 'Invalid email address format.'));
          break;
        case 'missing-email':
          emit(ResetPasswordFailure(errMassege: 'Please enter an email.'));
          break;
        default:
          emit(ResetPasswordFailure(errMassege: 'Something went wrong. Please try again.'));
      }
    } catch (e) {
      emit(ResetPasswordFailure(errMassege: 'Unexpected error occurred.'));
    }
  }
}
