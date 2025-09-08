import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tixclick/api/endpoint/endpoint.dart';
import 'package:tixclick/models/register_user_model.dart';

class AuthService {
  static Future<RegisterUserModel?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(Endpoint.login),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      print('Login Response status: ${response.statusCode}');
      print('Login Response body: ${response.body}'); // DEBUG

      if (response.statusCode == 200) {
        final userData = registerUserModelFromJson(response.body);

        // PERBAIKAN: Token sekarang di root, bukan dalam data
        if (userData.token != null && userData.token!.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', userData.token!);
          print('Token saved: ${userData.token}'); // DEBUG
        } else {
          print('Token is null or empty'); // DEBUG
        }

        return userData;
      } else {
        // Handle error response
        final errorData = json.decode(response.body);
        final errorMessage =
            errorData['message'] ??
            'Login failed with status ${response.statusCode}';
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Login error: $e'); // DEBUG
      throw Exception('Login failed: $e');
    }
  }

  static Future<RegisterUserModel?> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(Endpoint.register),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
        }),
      );

      print('Register Response status: ${response.statusCode}');
      print('Register Response body: ${response.body}'); // DEBUG

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userData = registerUserModelFromJson(response.body);

        // PERBAIKAN: Token sekarang di root, bukan dalam data
        if (userData.token != null && userData.token!.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', userData.token!);
          print('Token saved: ${userData.token}'); // DEBUG
        } else {
          print('Token is null or empty'); // DEBUG
        }

        return userData;
      } else {
        // Handle error response
        final errorData = json.decode(response.body);
        final errorMessage =
            errorData['message'] ??
            'Registration failed with status ${response.statusCode}';
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Registration error: $e'); // DEBUG
      throw Exception('Registration failed: $e');
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    print('User logged out and token removed'); // DEBUG
  }

  // Method untuk check jika user sudah login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final isLoggedIn = token != null && token.isNotEmpty;
    print('User logged in: $isLoggedIn'); // DEBUG
    return isLoggedIn;
  }

  // Method untuk mendapatkan token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('Retrieved token: $token'); // DEBUG
    return token;
  }

  // Method untuk mendapatkan user data dari shared preferences (jika disimpan)
  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString('user_data');
    if (userDataJson != null) {
      return json.decode(userDataJson);
    }
    return null;
  }

  // Method untuk menyimpan user data ke shared preferences
  static Future<void> saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', json.encode(user.toJson()));
    print('User data saved: ${user.toJson()}'); // DEBUG
  }
}
