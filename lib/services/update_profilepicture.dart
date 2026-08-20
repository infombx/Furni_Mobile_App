import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileService {
  final String baseUrl = "http://159.65.15.249:1337";
  final Dio dio = Dio();

  Future<bool> updateProfilePicture(String imagePath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jwt = prefs.getString('jwt');
      final userId = prefs.getInt('userId');

      dio.options.headers = {'Authorization': 'Bearer $jwt'};

      // 1️⃣ Upload image
      final formData = FormData.fromMap({
        'files': await MultipartFile.fromFile(imagePath),
      });

      final uploadRes = await dio.post('$baseUrl/api/upload', data: formData);

      final imageId = uploadRes.data[0]['id'];

      // 2️⃣ Update user profile picture
      final res = await dio.put(
        '$baseUrl/api/users/$userId',
        data: {
          'profilePicture': imageId, // ✅ correct for Users API
        },
      );

      return res.statusCode == 200;
    } catch (e) {
      print('UPDATE PROFILE PIC ERROR: $e');
      return false;
    }
  }
}
