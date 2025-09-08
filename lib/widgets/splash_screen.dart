import 'package:flutter/material.dart';
import 'package:tixclick/extension/navigation.dart';
import 'package:tixclick/preference/shared_preference.dart';
import 'package:tixclick/screens/login_screen.dart';
import 'package:tixclick/screens/main_screen.dart';
import 'package:tixclick/widgets/appimage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const id = "/splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _checkLogin() async {
    bool? isLogin = await PreferenceHandler.getLogin();

    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (!mounted) return;

      if (isLogin == true) {
        context.pushReplacementNamed(MainScreen.id);
      } else {
        context.push(LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(AppImage.Background, fit: BoxFit.cover, width: 350),
      ),
    );
  }
}
