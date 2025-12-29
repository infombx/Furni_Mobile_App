import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  /// Minimal implementation used by the profile screen.
  /// Saves profile fields locally and returns success.
  Future<bool> createUserProfile({
    required String firstName,
    required String lastName,
    required String displayName,
    String? imagePath,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('firstName', firstName);
      await prefs.setString('lastName', lastName);
      await prefs.setString('displayName', displayName);
      if (imagePath != null) {
        await prefs.setString('profileImagePath', imagePath);
      }
      return true;
    } catch (_) {
      return false;
    }
  }
}
