import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final String _imageKey = 'profile_image_path';

  Future<void> loadProfileImage() async {
    try {
      emit(ProfileLoading());
      final prefs = await SharedPreferences.getInstance();
      final imagePath = prefs.getString(_imageKey);

      if (imagePath != null && File(imagePath).existsSync()) {
        emit(ProfileLoaded(File(imagePath)));
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

      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_imageKey, pickedFile.path);

        emit(ProfileLoaded(imageFile));
      } else {
        emit(ProfileInitial()); // المستخدم رجع بدون اختيار صورة
      }
    } catch (e) {
      emit(ProfileFailure('Failed to pick image'));
    }
  }
}
