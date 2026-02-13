import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final String baseUrl = "http://159.65.15.249:1337";


  final Dio dio = Dio();

  Future<bool> createUserProfile({
    required String firstName,
    required String lastName,
    required String displayName,
    String? imagePath,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jwt = prefs.getString('jwt');
      final userId = prefs.getInt('userId');

      dio.options.headers = {'Authorization': 'Bearer $jwt'};

      int? imageId;

      if (imagePath != null) {
        final formData = FormData.fromMap({
          'files': await MultipartFile.fromFile(imagePath),
        });

        final uploadRes = await dio.post('$baseUrl/api/upload', data: formData);

        imageId = uploadRes.data[0]['id'];
      }

      final Map<String, dynamic> data = {
        'firstName': firstName,
        'lastName': lastName,
        'displayName': displayName,
      };

      if (imageId != null) {
        data['profilePicture'] = imageId;
      }

      final res = await dio.put('$baseUrl/api/users/$userId', data: data);

      return res.statusCode == 200;
    } catch (e) {
      print('CREATE PROFILE ERROR: $e');
      return false;
    }
  }
}
