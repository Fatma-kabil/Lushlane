// user_profile_state.dart
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final String? name;
  final String? email;
  final String? password;  // حفظ الباسورد القديم فقط

  UserProfileLoaded({this.name, this.email, this.password});
}

class UserProfileError extends UserProfileState {
  final String message;

  UserProfileError({required this.message});
}
