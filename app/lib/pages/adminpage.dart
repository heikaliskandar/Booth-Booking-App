// ignore_for_file: unused_local_variable

import 'admin/admin_main_menu.dart';
import 'package:flutter/material.dart';
import '../common_widgets/buttons.dart';
import '../common_widgets/inputs.dart';
import '../models/user.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double fontSize = 14;

    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(2 * 16, 0, 2 * 16, 0),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenWidth,
                      child: const Padding(
                        padding: EdgeInsets.all(3 * 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 6 * 2),
                            Text(
                              'Welcome Back Admin!',
                              style: TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 24, 43, 92),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10 * 1),
                            Text(
                              'Welcome To Booth Booking System',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 54, 54, 54),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            3 * 16, 0, 3 * 16, 3 * 16),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(255, 54, 54, 54),
                                  width: 0.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InputText(
                                controller: usernameController,
                                icons: Icons.person,
                                label: 'Username',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username.';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(255, 54, 54, 54),
                                  width: 0.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InputPassword(
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password.';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              width: 400,
                              height: 60,
                              child: ButtonGradient(
                                label: 'Login',
                                textStyle: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                borderRadius: 20,
                                gradientColor: const [
                                  Color.fromARGB(255, 24, 43, 92),
                                  Color.fromARGB(255, 24, 43, 92),
                                ],
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    User user = User(
                                      username: usernameController.text,
                                      password: passwordController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                    );

                                    if (user.username == 'admin123' &&
                                        user.password == '123456') {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AdminPageWidget(),
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Invalid Credentials'),
                                            content: const Text(
                                                'The username or password is incorrect.'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
