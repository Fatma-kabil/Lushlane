import 'package:bloc/bloc.dart';
import 'package:lushlane_app/core/utils/profile_repositry.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/user_profile/user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final ProfileRepository _profileRepository;

  UserProfileCubit(this._profileRepository) : super(UserProfileInitial());

  Future<void> loadUserData() async {
    try {
      emit(UserProfileLoading());
      final userData = _profileRepository.getCurrentUser();

      if (userData == null) {
        emit(UserProfileError(message: 'No user is logged in.'));
        return;
      }

      emit(UserProfileLoaded(
        name: userData.displayName,
        email: userData.email,
        password: '********',
      ));
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }

  Future<void> updateName(String name) async {
    try {
      emit(UserProfileLoading());
      await _profileRepository.updateName(name);
      await loadUserData();
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }

  Future<void> updateEmail(String currentEmail, String password, String newEmail) async {
    try {
      emit(UserProfileLoading());
      await _profileRepository.updateEmail(
        currentEmail: currentEmail,
        password: password,
        newEmail: newEmail,
      );
      await loadUserData();
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }

  Future<void> updatePassword(String email, String currentPassword, String newPassword) async {
    try {
      emit(UserProfileLoading());
      await _profileRepository.updatePassword(
        email: email,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      await loadUserData();
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }
}
