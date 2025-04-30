part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}




class UserProfileLoaded extends UserProfileState {
  final String? name;
  final String? email;
  


  UserProfileLoaded(this.name, this.email,);
}

class UserProfileError extends UserProfileState {
  final String message;

  UserProfileError(this.message);
}