part of 'signup_cubit.dart';

@immutable
sealed class SignupStates {}

final class SignupInitial extends SignupStates {}

class SignupSuccess extends SignupStates {}

class SignupLoading extends SignupStates {}

class SignupFailure extends SignupStates {
  String errMassege;
  SignupFailure({required this.errMassege});
}
