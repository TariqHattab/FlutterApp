import 'package:flutter/material.dart';

import 'Intray/intray_page.dart';
import 'Intray/months_page.dart';
import 'Intray/register/register_page.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: new Scaffold(
          body: Stack(children: <Widget>[
            TabBarView(
              children: [
                IntrayPage(
                    // tasks: tasks,
                    ),
                new Container(
                  color: Colors.orange,
                  child: Center(
                    child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        },
                        child: Text(' open register page')),
                  ),
                ),
                MonthsPage()
              ],
            ),
          ]),
          appBar: new TabBar(
              tabs: [
                Tab(
                  icon: new Icon(Icons.home),
                ),
                Tab(
                  icon: new Icon(Icons.rss_feed),
                ),
                Tab(
                  icon: new Icon(Icons.perm_identity),
                )
              ],
              labelColor: Colors.greenAccent,
              unselectedLabelColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Colors.green),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
