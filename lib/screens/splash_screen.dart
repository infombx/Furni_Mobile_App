import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teakworld/screens/login_screen.dart';
import 'package:teakworld/screens/signup_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      const Color(0xFF122f3b),
                      const Color(0xFF1E485B),
                      const Color(0xFF409AC1),
                    ],
                    stops: [0.0, 0.23, 0.88],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(400, 190),
                    bottomRight: Radius.elliptical(10, 1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    SvgPicture.asset('assets/images/teakworld.mu-0.svg', height: 40),
                    const SizedBox(height: 15),
                    const Text(
                      'Furniture that feels like home',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Expanded(
                      child: Image.asset(
                        'assets/images/sofa2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              SizedBox(
                width: 300,
                height: 56,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff1E485B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 305,
                height: 56,
                child: TextButton(
                  style: TextButton.styleFrom(
                    side: BorderSide(color: const Color(0xff1E485B), width: 2),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const SignUpScreen()),
                    );
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Color(0xff1E485B), fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
