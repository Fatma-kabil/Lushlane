import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lushlane_app/core/utils/stripe_service.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signup_states.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitial());

  Future<void> signupUser({
    required String email,
    required String password,
    required String name,
  }) async {
    print('Started loading...');
    emit(SignupLoading());

    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // هنا بنضيف الاسم كـ displayName في Firebase Auth
      await user.user!.updateDisplayName(name);

      final stripeCustomerId = await StripeService().createStripeCustomer(email: email);

    // خزني customerId محليًا
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('stripeCustomerId', stripeCustomerId);


      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email-format' || e.code == 'invalid-email') {
        emit(SignupFailure(errMassege: 'Invalid email format'));
      } else if (e.code == 'weak-password') {
        emit(SignupFailure(errMassege: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupFailure(errMassege: 'email-already-in-use'));
      }
    } on Exception {
      emit(SignupFailure(errMassege: 'Somthing went wrong'));
    }
  }
}
