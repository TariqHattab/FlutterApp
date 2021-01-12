import 'package:flutter/material.dart';

Color darkGrayColor = new Color(0xFF212128);
Color redColor = new Color(0xFFDC4F64);

TextStyle itrayTextStyle = new TextStyle(
    fontFamily: 'Avenir', fontWeight: FontWeight.bold, fontSize: 40);

TextStyle notSelectedTextStyle =
    new TextStyle(fontFamily: 'Avenir', color: Colors.black26, fontSize: 40);

TextStyle selectedTextStyle = new TextStyle(
    fontFamily: 'Avenir', fontWeight: FontWeight.bold, fontSize: 40);

TextStyle titleTextStyle = new TextStyle(
    fontFamily: 'Avenir', fontWeight: FontWeight.bold, fontSize: 15);

List<Widget> pageWidget = <Widget>[
  Row(children: <Widget>[Text('Intray', style: itrayTextStyle), Container()]),
  Text('hi'),
  Text('hello')
];

int pageNum = 0;

createListTile(String text, List<bool> enabledList, int i, Function func) {
  return Container(
      height: 200,
      width: 200,
      child: Center(
          child: GestureDetector(
        onTap: () {
          print(enabledList[i]);
          func(i);
          print(enabledList[i]);
        },
        child: Text(
          text,
          style: enabledList[i] ? selectedTextStyle : notSelectedTextStyle,
        ),
      )));
}
