import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';
  static const String _userNameKey = 'user_name';

  // Simpan token setelah login
  static Future<void> saveToken(String? token) async {
    if (token != null && token.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }
  }

  // static Future<void> saveToken(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_tokenKey, token);
  // }

  // Ambil token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // static Future<String?> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_tokenKey);
  // }

  // Hapus token (logout)
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Simpan user ID
  static Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userId);
  }

  // Ambil user ID
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  // Simpan user email
  static Future<void> saveUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
  }

  // static Future<void> saveUserEmail(String email) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_userEmailKey, email);
  // }

  // Ambil user email
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  // static Future<String?> getUserEmail() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_userEmailKey);
  // }

  // Simpan user name
  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
  }

  // static Future<void> saveUserName(String name) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_userNameKey, name);
  // }

  // Ambil user name
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name');
  }

  // static Future<String?> getUserName() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_userNameKey);
  // }

  // Cek apakah user sudah login
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Dapatkan semua data user
  static Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString(_tokenKey),
      'user_id': prefs.getInt(_userIdKey),
      'email': prefs.getString(_userEmailKey),
      'name': prefs.getString(_userNameKey),
    };
  }

  // Simpan semua data user setelah login
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();

    if (userData['token'] != null) {
      await prefs.setString(_tokenKey, userData['token']);
    }
    if (userData['user_id'] != null) {
      await prefs.setInt(_userIdKey, userData['user_id']);
    }
    if (userData['email'] != null) {
      await prefs.setString(_userEmailKey, userData['email']);
    }
    if (userData['name'] != null) {
      await prefs.setString(_userNameKey, userData['name']);
    }
  }

  // Logout - hapus semua data user
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userNameKey);
  }

  // Clear semua data preferences (untuk debug)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
