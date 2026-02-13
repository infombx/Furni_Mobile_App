import 'package:flutter/material.dart';
import 'package:teakworld/screens/home_screen.dart';
import 'package:teakworld/screens/splash_screen.dart';
import 'package:teakworld/services/OrdersService.dart';
import 'package:teakworld/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CartPersistence.loadCart();

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
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),

      // ✅ AUTO LOGIN DECISION HERE
      initialRoute: autoLogin ? HomeScreen.routeName : SplashScreen.routeName,

      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),

        SplashScreen.routeName: (_) => const SplashScreen(),
      },
    );
  }
}
