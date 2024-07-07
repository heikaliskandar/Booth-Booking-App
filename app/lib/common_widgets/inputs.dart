import 'package:flutter/material.dart';

// Text Input
class InputText extends StatelessWidget {
  const InputText({
    Key? key,
    required this.icons,
    required this.label,
    this.validator,
    this.controller,
  }) : super(key: key);

  final IconData icons;
  final String label;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        color: Color.fromARGB(255, 4, 87, 150),
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
        ),
        hintText: label,
        // hintStyle: const TextStyle(),
        hintStyle: TextStyle(
            fontSize: 20.0, color: const Color.fromARGB(255, 4, 87, 150)),
        prefixIcon: Icon(
          icons,
          color: Color.fromARGB(255, 4, 87, 150),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 50,
        ),
      ),
      validator: validator,
    );
  }
}

// Password Input
class InputPassword extends StatelessWidget {
  const InputPassword({
    Key? key,
    this.validator,
    this.controller,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      obscuringCharacter: '*',
      style: const TextStyle(
        color: Color.fromARGB(255, 4, 87, 150),
        fontWeight: FontWeight.bold,
      ),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
        ),
        hintText: 'Password',
        hintStyle: TextStyle(
            fontSize: 20.0, color: const Color.fromARGB(255, 4, 87, 150)),
        prefixIcon: Icon(
          Icons.lock,
          color: Color.fromARGB(255, 4, 87, 150),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 50,
        ),
      ),
      validator: validator,
    );
  }
}
