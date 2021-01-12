import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:myapp1/UI/Intray/register/common_page.dart';
import 'package:myapp1/UI/Intray/register/signin_page.dart';
import 'package:myapp1/UI/Intray/register/signup_page.dart';
import 'package:myapp1/models/global.dart';
import 'package:requests/requests.dart';

class RegisterPage extends StatefulWidget {
  final List tasks;

  RegisterPage({Key key, this.tasks}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print(visible);
        // Add state updating code
        setState(() {
          empetyBox = visible
              ? SizedBox(
                  height: 0,
                )
              : SizedBox(
                  height: 70,
                );
        });
      },
    );
    super.initState();
  }

  Function _getRegisterPage() {
    if (signIn) {
      return getSignInPage;
    } else {
      return getSignUpPage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: darkGrayColor,
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: SingleChildScrollView(
          child: Container(
              // height: 500,
              margin: EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 50),
              child: _getRegisterPage()(context, setState)),
        ),
      ),
    );
  }
}
