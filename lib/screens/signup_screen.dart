import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furni_mobile_app/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/screens/profile.dart';
import 'package:furni_mobile_app/services/auth_service.dart';
import 'package:furni_mobile_app/models/user_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool rememberMe = false;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _signUpKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  /// =========================
  /// REGISTER USER
  /// =========================
  Future<void> registerUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    setState(() => isLoading = true);

    try {
      final AppUser? user = await authService.register(
        email,
        password,
        rememberMe: rememberMe,
      );

      setState(() => isLoading = false);

      if (user != null) {
        // Registration successful, navigate to CompleteProfileScreen
        final jwtToken = user.jwtToken;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const CompleteProfileScreen()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Registration failed')));
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _signUpKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo + Image
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Center(
                          child: Image.asset(
                            'assets/images/welcome.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/furniLogo.svg',
                            width: 70,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Title
                  Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Sign in link
                  Row(
                    children: [
                      Text(
                        'Already have an account?',
                        style: GoogleFonts.inter(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign in',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: const Color(0xFF1E485B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Email field
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex.hasMatch(value.trim())) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Password field
                  TextField(
                    controller: passwordController,
                    obscureText: !passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const UnderlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Confirm Password field
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: !confirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: const UnderlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            confirmPasswordVisible = !confirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Remember me checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text(
                        'Remember me',
                        style: GoogleFonts.inter(fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Sign Up button
                  Center(
                    child: SizedBox(
                      width: 311,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : registerUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF184E60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
