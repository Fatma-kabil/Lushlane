part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}




class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final File profileImage;
  ProfileLoaded(this.profileImage);
}

class ProfileFailure extends ProfileState {
  final String errorMessage;
  ProfileFailure(this.errorMessage);
}