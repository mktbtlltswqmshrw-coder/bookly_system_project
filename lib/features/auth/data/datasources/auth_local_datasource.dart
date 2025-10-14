import 'package:shared_preferences/shared_preferences.dart';

/// Abstract class for local authentication data source
abstract class AuthLocalDataSource {
  Future<void> saveUserSession(String userId, String email);
  Future<Map<String, String>?> getUserSession();
  Future<void> clearUserSession();
}

/// Implementation of AuthLocalDataSource using SharedPreferences
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveUserSession(String userId, String email) async {
    await sharedPreferences.setString('user_id', userId);
    await sharedPreferences.setString('user_email', email);
    await sharedPreferences.setBool('is_logged_in', true);
  }

  @override
  Future<Map<String, String>?> getUserSession() async {
    final userId = sharedPreferences.getString('user_id');
    final email = sharedPreferences.getString('user_email');
    final isLoggedIn = sharedPreferences.getBool('is_logged_in') ?? false;

    if (userId != null && email != null && isLoggedIn) {
      return {'user_id': userId, 'email': email};
    }
    return null;
  }

  @override
  Future<void> clearUserSession() async {
    await sharedPreferences.remove('user_id');
    await sharedPreferences.remove('user_email');
    await sharedPreferences.remove('is_logged_in');
  }
}
