import 'package:flutter/material.dart';
import 'package:tixclick/screens/login_screen.dart';
import 'package:tixclick/screens/main_screen.dart';
import 'package:tixclick/widgets/splash_screen.dart';

void main() {
  runApp(const TixClickApp());
}

// Custom Navy Color
const MaterialColor navy = MaterialColor(0xFF001F3F, <int, Color>{
  50: Color(0xFFE6E9ED),
  100: Color(0xFFC0C8D1),
  200: Color(0xFF97A4B3),
  300: Color(0xFF6D8095),
  400: Color(0xFF4D647E),
  500: Color(0xFF001F3F), // Navy utama
  600: Color(0xFF001B39),
  700: Color(0xFF001731),
  800: Color(0xFF001229),
  900: Color(0xFF000A1B),
});

class TixClickApp extends StatelessWidget {
  const TixClickApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TixClick',
      theme: ThemeData(
        // HAPUS ThemeData bersarang di sini:
        // theme: ThemeData(  <-- INI SALAH
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color(0x553D5CFF),
          selectionHandleColor: Colors.white,
        ),
        primarySwatch: navy, // Menggunakan custom navy color
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF001F3F), // Warna navy
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF001F3F), // Warna navy
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(
              0xFF001F3F,
            ), // Warna navy untuk text button
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF001F3F), // Warna navy untuk FAB
        ),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF001F3F), // Warna navy sebagai primary
          secondary: Color(0xFF3D5AFE), // Warna aksen yang cocok dengan navy
        ),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        LoginScreen.id: (context) =>
            const LoginScreen(), // Pastikan route ini ada
        SplashScreen.id: (context) => const SplashScreen(),
        MainScreen.id: (context) => const MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
