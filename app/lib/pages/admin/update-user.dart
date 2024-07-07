import 'package:flutter/material.dart';
import '../../common_widgets/buttons.dart';
import '../../common_widgets/inputs.dart';
import '../../models/user.dart';

class AdminUpdateUser extends StatefulWidget {
  final String userID;

  const AdminUpdateUser({Key? key, required this.userID}) : super(key: key);

  @override
  State<AdminUpdateUser> createState() => _AdminUpdateUserState();
}

class _AdminUpdateUserState extends State<AdminUpdateUser> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    String? userId = widget.userID;

    User? fetchedUser = await User.getUserDetailsById(userId);

    if (fetchedUser != null) {
      setState(() {
        usernameController.text = fetchedUser.username;
        passwordController.text = fetchedUser.password;
        emailController.text = fetchedUser.email;
        phoneController.text = fetchedUser.phone;
      });
    }
  }

  Future<void> updateUsers() async {
    String? userId = widget.userID;

    if (phoneController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all the fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    User user = User(
      id: int.parse(userId),
      username: usernameController.text,
      password: passwordController.text,
      email: emailController.text,
      phone: phoneController.text,
    );

    await User.updateUser(user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User has been updated successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> deleteUser() async {
    String? userId = widget.userID;
    User.deleteUser(userId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User has been deleted successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 6 * 2),
                              Text(
                                'Update User account',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: Color.fromARGB(255, 24, 43, 92),
                                ),
                              ),
                              SizedBox(height: 10 * 1),
                            ],
                          ),
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
                                controller: emailController,
                                icons: Icons.email,
                                label: 'Email',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email.';
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
                              child: InputText(
                                controller: phoneController,
                                icons: Icons.phone,
                                label: 'Phone',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number.';
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
                              child: InputText(
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10), // Add top padding
                              child: SizedBox(
                                width: 400,
                                height: 60,
                                child: ButtonGradient(
                                  label: 'Update',
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
                                  onPressed: updateUsers,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10), // Add top padding
                              child: SizedBox(
                                width: 400,
                                height: 60,
                                child: ButtonGradient(
                                  label: 'Delete',
                                  textStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  borderRadius: 20,
                                  gradientColor: const [
                                    Color.fromARGB(255, 92, 24, 24),
                                    Color.fromARGB(255, 92, 24, 24),
                                  ],
                                  onPressed: deleteUser,
                                ),
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
