import 'package:flutter_basic_auth/models/user_model.dart';
import 'package:flutter_basic_auth/services/http_service.dart';
import 'package:flutter_basic_auth/services/storage_service.dart';

abstract class AuthService {
  static const String TOKEN_KEY = 'token';
  static User currentUser;

  static Future<Map> getCurrentUserFromAPI() async {
    var response = await HttpService.get('/me');

    return response.data['user'];
  }

  static Future<String> getToken() async {
    return await StorageService.read(TOKEN_KEY);
  }

  static void setToken(String token) {
    StorageService.write(TOKEN_KEY, token);
    HttpService.setToken(token);
  }

  static void deleteToken() {
    StorageService.delete(TOKEN_KEY);
    HttpService.unsetToken();
  }

  static void setCurrentUser(Map user) {
    currentUser = User.fromJson(user);
  }

  static void unsetCurrentUser() {
    currentUser = null;
  }

  static Future<bool> check() async {
    String token = await getToken();

    if (token != null) {
      HttpService.setToken(token);

      try {
        var user = await getCurrentUserFromAPI();

        setCurrentUser(user);

        return true;
      } catch (e) {
        logout();
        return false;
      }
    }

    return false;
  }

  static Future<bool> authenticate(String email, String password) async {
    var data = {
      'email': email,
      'password': password,
    };

    try {
      var response = await HttpService.post('/login', data: data);
      var user = response.data['user'];
      var token = response.data['token'];

      setCurrentUser(user);
      setToken(token);

      return true;
    } catch (e) {
      return false;
    }
  }

  static void logout() {
    deleteToken();
    unsetCurrentUser();
  }
}
