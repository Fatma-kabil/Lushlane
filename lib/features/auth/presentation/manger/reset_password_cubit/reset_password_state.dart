part of 'reset_password_cubit.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

// ignore: must_be_immutable
class ResetPasswordFailure extends ResetPasswordState {
  String errMassege;
  ResetPasswordFailure({required this.errMassege});
}
