import 'package:flutter/material.dart';
import '../models/user.dart';
import '../common_widgets/buttons.dart' as common_buttons;
import 'login.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
    debugPrint('AccountPage initialized with user ID: ${widget.user.id}');
  }

  Future<void> loadUserDetails() async {
    final userDetails = await User.getUserDetails(widget.user.username);
    if (userDetails != null) {
      setState(() {
        usernameController.text = userDetails.username;
        emailController.text = userDetails.email;
        phoneController.text = userDetails.phone;
        passwordController.text = userDetails.password;
      });
    }
  }

  Future<void> updateUserDetails() async {
    String? userId = widget.user.id?.toString();
    debugPrint('Updating user details for ID: $userId');

    if (userId == null) {
      print('User ID is null');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User ID is invalid. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

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
      id: int.tryParse(userId) ?? 0,
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
    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: const Color.fromARGB(255, 200, 209, 230),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Hero(
                  tag: "profile",
                  child: SizedBox(
                    height: 95,
                    width: 130,
                    child: Image.asset("assets/image/avatar.png"),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    icon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  enabled: false,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  enabled: isEditing,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    icon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  enabled: isEditing,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  obscureText: true,
                  enabled: isEditing,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                if (isEditing)
                  common_buttons.ButtonGradient(
                    onPressed: updateUserDetails,
                    label: 'Save',
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    borderRadius: 20,
                    gradientColor: const [
                      Color(0xFF0D47A1),
                      Color(0xFF0D47A1),
                    ],
                  )
                else
                  common_buttons.ButtonGradient(
                    onPressed: () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                    label: 'Edit Profile',
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    borderRadius: 20,
                    gradientColor: const [
                      Color(0xFF0D47A1),
                      Color(0xFF0D47A1),
                    ],
                  ),
                const SizedBox(height: 20),
                common_buttons.ButtonGradient(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false,
                    );
                  },
                  label: 'Log Out',
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  borderRadius: 50,
                  gradientColor: const [
                    Color(0xFF0D47A1),
                    Color(0xFF0D47A1),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
