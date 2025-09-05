class AuthService {
  static Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    // Simulasi login berhasil
    return email.isNotEmpty && password.isNotEmpty;
  }

  static Future<bool> register(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    // Simulasi registrasi berhasil
    return name.isNotEmpty && email.isNotEmpty && password.isNotEmpty;
  }

  static Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
