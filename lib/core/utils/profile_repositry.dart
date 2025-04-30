import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> updateName(String name) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      await user.reload(); // عشان التغييرات تتحدث فورًا
    }
  }

  Future<void> updateEmail(String email) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updateEmail(email);
      await user.reload();
    }
  }

  Future<void> updatePassword(String password) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updatePassword(password);
      await user.reload();
    }
  }
}
