import 'package:flutter/material.dart';
import 'package:furni_mobile_app/screens/home_screen.dart';
import 'package:furni_mobile_app/screens/splash_screen.dart';
import 'package:furni_mobile_app/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authService = AuthService();
  final bool autoLogin = await authService.shouldAutoLogin();

  runApp(MyApp(autoLogin: autoLogin));
}

class MyApp extends StatelessWidget {
  final bool autoLogin;

  const MyApp({super.key, required this.autoLogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
         ),
        scaffoldBackgroundColor: Colors.white, 
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: autoLogin
          ? const HomeScreen() 
          : const SplashScreen(),
    );
  }
}
