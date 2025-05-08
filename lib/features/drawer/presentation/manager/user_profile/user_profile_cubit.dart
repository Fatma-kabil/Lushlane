// user_profile_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:lushlane_app/core/utils/profile_repositry.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/user_profile/user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final ProfileRepository _profileRepository;

  UserProfileCubit(this._profileRepository) : super(UserProfileInitial());

  void loadUserData() async {
    try {
      emit(UserProfileLoading());
      final userData = _profileRepository.getCurrentUser();

      if (userData == null) {
        emit(UserProfileError(message: 'No user is logged in.'));
        return;
      }

      emit(
        UserProfileLoaded(
          name: userData.displayName,
          email: userData.email,
          password: '********', // placeholder فقط للعرض
        ),
      );
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }

  void updateName(String name) async {
    try {
      emit(UserProfileLoading());
      await _profileRepository.updateName(name);
      loadUserData(); // إعادة تحميل كل البيانات بعد التحديث
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }

  void updateEmail(String email) async {
    try {
      emit(UserProfileLoading());
      await _profileRepository.updateEmail(email);
      loadUserData();
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }

  void updatePassword(String password) async {
    try {
      emit(UserProfileLoading());
      await _profileRepository.updatePassword(password);
      loadUserData();
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }
}
