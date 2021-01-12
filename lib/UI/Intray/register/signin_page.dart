import 'package:flutter/material.dart';
import 'package:myapp1/UI/first_page.dart';
// import 'package:myapp1/UI/Intray/register/register_page.dart';
import 'package:myapp1/models/global.dart';
import 'package:requests/requests.dart';

import 'common_page.dart';

Widget getSignInPage(BuildContext context, setState) {
  return new Column(
    children: <Widget>[
      empetyBox,
      Text(
        'Welcome!',
        style: TextStyle(fontSize: 25, color: Colors.grey[200]),
      ),
      SizedBox(
        height: 80,
      ),
      createTextfield(usernameController, 'Username', usernameError),
      SizedBox(
        height: 15,
      ),
      createTextfield(passwordController, 'Password', passwordError),
      SizedBox(
        height: 15,
      ),
      FlatButton(
        color: Colors.transparent,
        child: Text('Sign in', style: TextStyle(fontSize: 17, color: redColor)),
        onLongPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FirstPage()),
          );
          //Navigator.pop(context);
        },
        onPressed: () async {
          if (usernameController.text != '' && passwordController.text != '') {
            var r =
                await Requests.patch('http://192.168.1.32:5000/api/Register',
                    body: {
                      'username': usernameController.text,
                      'password': passwordController.text,
                    },
                    bodyEncoding: RequestBodyEncoding.JSON);

            // r.raiseForStatus();
            dynamic json = r.json();
            print(r.content());
            // print(json);

            if (json['status'] == 'true') {
              setState(() {
                passwordError = null;
                usernameError = null;
                //Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstPage()),
                );
              });
            } else if (json['status'] == 'falseUser') {
              setState(() {
                print(usernameError);
                passwordError = null;
                usernameError = json['message'];
                print(usernameError);
              });
            } else if (json['status'] == 'falsePassword') {
              setState(() {
                usernameError = null;
                passwordError = json['message'];
              });
            }
          } else {
            if (usernameController.text == '') {
              setState(() {
                print('Username empty');
                usernameError = 'Must not be empty';
              });
            } else {
              setState(() {
                usernameError = null;
              });
            }

            if (passwordController.text == '') {
              setState(() {
                print('Password empty');
                passwordError = 'Must not be empty';
              });
            } else {
              setState(() {
                passwordError = null;
              });
            }
          }
        },
      ),
      SizedBox(
        height: 90,
      ),
      Text(
        "don't have an account",
        style: TextStyle(fontSize: 13, color: Colors.grey[400]),
      ),
      SizedBox(
        height: 10,
      ),
      FlatButton(
        onPressed: () {
          setState(() {
            signIn = false;
          });
        },
        child: Text('Sign up', style: TextStyle(fontSize: 17, color: redColor)),
        color: Colors.transparent,
      )
    ],
  );
}
