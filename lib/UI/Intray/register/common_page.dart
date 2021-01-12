import 'package:flutter/material.dart';

TextEditingController usernameController = TextEditingController();
TextEditingController firstnameController = TextEditingController();
TextEditingController lastnameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController emailController = TextEditingController();

String usernameError;
String firstnameError;
String lastnameError;
String passwordError;
String emailError;

Widget empetyBox = SizedBox(
  height: 70,
);
Alignment childAlignment = Alignment.center;

var signIn = true;

Widget createTextfield(
    TextEditingController controller, String hintText, String errorMassage) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white12),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        errorText: errorMassage,
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white12),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: EdgeInsets.all(8)),
  );
}
