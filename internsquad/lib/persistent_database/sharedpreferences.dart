import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  Future<bool> setAuthToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString('token', token);
  }

  Future<String?> getAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if (token != null) {
      return token;
    } else {
      return '';
    }
  }

  void removeAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('token');
    print(pref.getString('token'));
  }
}
