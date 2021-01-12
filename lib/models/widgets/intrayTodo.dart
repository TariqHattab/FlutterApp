import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/models/global.dart';

class IntrayTodo extends StatelessWidget {
  final String title;
  final Key key;
  final int numb;

  const IntrayTodo({this.key, this.title, this.numb}) : super(key: key);

  Widget _widget() {
    return Container(
      key: key,
      margin: EdgeInsets.only(bottom: 10, top: 10, right: 4, left: 4),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: redColor,
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10.0)]),
      child: Row(
        children: <Widget>[
          Radio(value: false, groupValue: true, onChanged: null),
          Column(
            children: <Widget>[
              Text(
                '$numb',
                style: titleTextStyle,
              ),
              Text(
                title,
                style: titleTextStyle,
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _widget();
  }
}
