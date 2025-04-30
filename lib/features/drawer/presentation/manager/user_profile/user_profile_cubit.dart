import 'package:bloc/bloc.dart';
import 'package:lushlane_app/core/utils/profile_repositry.dart';
import 'package:meta/meta.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
   final ProfileRepository _repository;
  UserProfileCubit(this._repository) : super(UserProfileInitial());

  
  void loadUserData() {
    final user = _repository.getCurrentUser();
    if (user != null) {
      emit(UserProfileLoaded(user.displayName, user.email));
    } else {
      emit(UserProfileError('User not logged in'));
    }
  }

  Future<void> updateName(String name) async {
    try {
      await _repository.updateName(name);
      final user = _repository.getCurrentUser();
      emit(UserProfileLoaded(user?.displayName, user?.email));
    } catch (e) {
      emit(UserProfileError('Failed to update name: $e'));
    }
  }

  Future<void> updateEmail(String email) async {
    try {
      await _repository.updateEmail(email);
      final user = _repository.getCurrentUser();
      emit(UserProfileLoaded(user?.displayName, user?.email));
    } catch (e) {
      emit(UserProfileError('Failed to update email: $e'));
    }
  }

  Future<void> updatePassword(String password) async {
    try {
      await _repository.updatePassword(password);
      final user = _repository.getCurrentUser();
      emit(UserProfileLoaded(user?.displayName, user?.email));
    } catch (e) {
      emit(UserProfileError('Failed to update password: $e'));
    }
  }
}
