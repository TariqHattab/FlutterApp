// import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/UI/Intray/intray_page.dart';
import 'package:myapp1/UI/Intray/register/register_page.dart';
import 'UI/Intray/months_page.dart';
import 'models/global.dart';
import 'package:requests/requests.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red))),
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return RegisterPage();
  }
}
// SafeArea(
//       child: DefaultTabController(
//         length: 3,
//         child: new Scaffold(
//           body: Stack(children: <Widget>[
//             TabBarView(
//               children: [
//                 IntrayPage(
//                     // tasks: tasks,
//                     ),
//                 new Container(
//                   color: Colors.orange,
//                   child: Center(
//                     child: FlatButton(
//                         onPressed: () {
// Navigator.push(
//   context,
//   MaterialPageRoute(
//       builder: (context) => RegisterPage()),
// );
//                         },
//                         child: Text(' open register page')),
//                   ),
//                 ),
//                 MonthsPage()
//               ],
//             ),
//           ]),
//           appBar: new TabBar(
//               tabs: [
//                 Tab(
//                   icon: new Icon(Icons.home),
//                 ),
//                 Tab(
//                   icon: new Icon(Icons.rss_feed),
//                 ),
//                 Tab(
//                   icon: new Icon(Icons.perm_identity),
//                 )
//               ],
//               labelColor: Colors.greenAccent,
//               unselectedLabelColor: Colors.blue,
//               indicatorSize: TabBarIndicatorSize.label,
//               indicatorPadding: EdgeInsets.all(5.0),
//               indicatorColor: Colors.green),
//           backgroundColor: Colors.white,
//         ),
//       ),
//     );
//   }
