import 'package:bloc/bloc.dart';
import 'package:lushlane_app/core/utils/profile_image_manager.dart';
import 'package:meta/meta.dart';
import 'dart:io';
// استيراد الكلاس الجديد

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileImageManager _profileImageManager;

  ProfileCubit(this._profileImageManager) : super(ProfileInitial());

  Future<void> loadProfileImage() async {
    try {
      emit(ProfileLoading());
      final imageFile = await _profileImageManager.loadProfileImage();

      if (imageFile != null) {
        emit(ProfileLoaded(imageFile));
      } else {
        emit(ProfileInitial()); // مفيش صورة محفوظة
      }
    } catch (e) {
      emit(ProfileFailure('Failed to load image'));
    }
  }

  Future<void> pickImage() async {
    try {
      emit(ProfileLoading());
      final imageFile = await _profileImageManager.pickImage();

      if (imageFile != null) {
        emit(ProfileLoaded(imageFile));
      } else {
        emit(ProfileInitial()); // المستخدم رجع بدون اختيار صورة
      }
    } catch (e) {
      emit(ProfileFailure('Failed to pick image'));
    }
  }
}
