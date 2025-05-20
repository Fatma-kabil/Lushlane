import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? getCurrentUser() => _auth.currentUser;

  Future<void> updateName(String name) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No user logged in");
    await user.updateDisplayName(name);
  }

  Future<void> updateEmail({
    required String currentEmail,
    required String password,
    required String newEmail,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No user logged in");

    final cred = EmailAuthProvider.credential(email: currentEmail, password: password);
    await user.reauthenticateWithCredential(cred); // ✅ إعادة التوثيق
    await user.updateEmail(newEmail);
  }

  Future<void> updatePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No user logged in");

    final cred = EmailAuthProvider.credential(email: email, password: currentPassword);
    await user.reauthenticateWithCredential(cred); // ✅ إعادة التوثيق
    await user.updatePassword(newPassword);
  }
}
