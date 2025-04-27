import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImageManager {
  final String _imageKey = 'profile_image_path';

  // تحميل الصورة من SharedPreferences
  Future<File?> loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString(_imageKey);

    if (imagePath != null && File(imagePath).existsSync()) {
      return File(imagePath);
    }
    return null; // رجوع null لو مفيش صورة محفوظة
  }

  // اختيار صورة من المعرض
  Future<File?> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_imageKey, pickedFile.path); // حفظ المسار في SharedPreferences
      return imageFile;
    }
    return null; // رجوع null لو المستخدم رجع بدون صورة
  }
}
