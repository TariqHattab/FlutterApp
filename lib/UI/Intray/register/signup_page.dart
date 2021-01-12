import 'package:flutter/material.dart';
import 'package:myapp1/models/global.dart';
import 'package:requests/requests.dart';

import '../../first_page.dart';
import 'common_page.dart';

Widget getSignUpPage(BuildContext context, setState) {
  return new Column(
    children: <Widget>[
      empetyBox,
      Text(
        'Welcome!',
        style: TextStyle(color: Colors.grey[300], fontSize: 28),
      ),
      SizedBox(
        height: 40,
      ),
      createTextfield(usernameController, 'Username', usernameError),
      SizedBox(
        height: 15,
      ),
      createTextfield(firstnameController, 'Firstname', firstnameError),
      SizedBox(
        height: 15,
      ),
      createTextfield(lastnameController, 'Lastname', lastnameError),
      SizedBox(
        height: 15,
      ),
      createTextfield(passwordController, 'Password', passwordError),
      SizedBox(
        height: 15,
      ),
      createTextfield(emailController, 'Email', emailError),
      SizedBox(
        height: 15,
      ),
      FlatButton(
        color: Colors.transparent,
        child: Text(
          'Sign up',
          style: TextStyle(color: redColor, fontSize: 17),
        ),
        onLongPress: () {
          //Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FirstPage()),
          );
        },
        onPressed: () async {
          var r = await Requests.post('http://192.168.1.32:5000/api/Register',
              body: {
                'username': usernameController.text,
                'lastName': lastnameController.text,
                'firstName': firstnameController.text,
                'password': passwordController.text,
                'email': emailController.text
              },
              bodyEncoding: RequestBodyEncoding.JSON);

          // r.raiseForStatus();
          dynamic json = r.json();
          print(r.content());
          print(json['message']);
          if (json['status'] == 'success') {
            //Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstPage()),
            );
          }
        },
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        "you have account",
        style: TextStyle(fontSize: 17, color: Colors.grey),
      ),
      SizedBox(
        height: 10,
      ),
      FlatButton(
        onPressed: () {
          setState(() {
            signIn = true;
          });
        },
        child: Text('Sign in', style: TextStyle(fontSize: 17, color: redColor)),
        color: Colors.transparent,
      ),
      SizedBox(
        height: 250,
      ),
    ],
  );
}
