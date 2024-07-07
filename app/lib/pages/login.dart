import 'package:flutter/material.dart';
import '../common_widgets/buttons.dart';
import '../common_widgets/inputs.dart';
import '../models/user.dart' as app_user;
import 'adminpage.dart';
import 'boothlist.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  bool isAdmin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Text(
                        'Welcome to Booth Booking System',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '"Book Your Space, Boost Your Pace!"',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 110, 207),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Please log in into your account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 24, 24, 24),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      InputText(
                        controller: usernameController,
                        icons: Icons.person_4_rounded,
                        label: 'Username',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      InputPassword(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 35),
                      SizedBox(
                        width: 200.0,
                        child: ButtonGradient(
                          label: 'Login',
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          borderRadius: 20,
                          gradientColor: const [
                            Color.fromARGB(255, 24, 43, 92),
                            Color.fromARGB(255, 24, 43, 92),
                          ],
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              app_user.User user = app_user.User(
                                username: usernameController.text,
                                password: passwordController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                              app_user.User.login(user, context);
                            }
                          },
                          stretch: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200.0,
                        child: ButtonGradient(
                          label: 'Package List',
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          borderRadius: 20,
                          gradientColor: const [
                            Color.fromARGB(255, 24, 43, 92),
                            Color.fromARGB(255, 24, 43, 92),
                          ],
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BoothList(),
                              ),
                            );
                          },
                          stretch: true, // Ensures the button stretches
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 255, 14, 14),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (isAdmin)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "I'm an",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AdminPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Admin",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 17, 17),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
