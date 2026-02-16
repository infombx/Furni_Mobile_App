import 'package:flutter/material.dart';
import 'package:teakworld/models/user_model.dart';
import 'package:teakworld/screens/login_screen.dart';
import 'package:teakworld/widgets/account details.dart';
import 'package:teakworld/services/auth_service.dart';
import 'package:teakworld/screens/home_screen.dart';
import 'package:teakworld/screens/splash_screen.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  AppUser? currentUser;
  bool isLoading = true;

  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await authService.fetchMe();
      setState(() {
        currentUser = user;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        currentUser = null;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Back Button ---
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          settings: const RouteSettings(name: '/home'),
                          builder: (_) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    label: const Text('back', style: TextStyle(color: Colors.black)),
                    icon: const Icon(Icons.arrow_back_ios, size: 11, color: Colors.black54),
                  ),
                ],
              ),

              const Center(
                child: Text(
                  'My Account',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // --- Conditional UI: Loader, User Name, or Sign In Button ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xfff3f5f7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isLoading)
                        const CircularProgressIndicator(color: Colors.black)
                      else if (currentUser != null)
                        Text(
                          currentUser!.displayName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        )
                      else ...[
                        const Text(
                          "You are not signed in",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(200, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                          },
                          child: const Text('Sign In', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // --- Detailed Info Section (Only shown if logged in) ---
              if (!isLoading && currentUser != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AccountDetails(
                    currentUser: currentUser,
                    isLoading: isLoading,
                    onProfileUpdated: () => _loadUser(),
                  ),
                ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}