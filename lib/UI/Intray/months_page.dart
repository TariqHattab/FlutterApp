import 'package:flutter/material.dart';
import 'package:myapp1/models/classes/task.dart';
import 'package:myapp1/models/global.dart';
import 'package:myapp1/models/widgets/intrayTodo.dart';
import 'package:requests/requests.dart';

class MonthsPage extends StatefulWidget {
  @override
  _MonthsPageState createState() => _MonthsPageState();
}

class _MonthsPageState extends State<MonthsPage> {
  List<int> dummyList = [
    1,
    3,
    5,
    6,
    8,
    9,
    0,
    7,
    2,
    3,
    4,
    5,
    1,
    4,
    2,
    6,
    4,
    6,
    7,
    3,
    5,
    7,
    5,
    8,
    3,
    2,
    3,
    6
  ];

  List taskList = new List();
  TextStyle ts = TextStyle(color: redColor);

  @override
  void initState() {
    setState(() {
      pageNum = 2;
    });
    // _sendGetRequest();
    super.initState();
  }

  _createTasksCard(int tasksNum) {
    List<Widget> tasks = [
      SizedBox(
        height: 4,
      )
    ];
    for (var i = 0; i < tasksNum; i++) {
      if (i < 5) {
        tasks.add(Container(
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 7.0),
          height: 2,
          width: 130,
          color: darkGrayColor,
        ));
      } else {
        tasks.add(Container(
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 7.0),
          height: 2,
          width: 130,
          color: Colors.black26,
        ));
        break;
      }
    }
    tasks.add(SizedBox(height: 2));

    return Container(
      height: 45,
      width: 35,
      decoration: BoxDecoration(
          color: redColor, borderRadius: BorderRadius.circular(10)),
      child: Column(children: tasks),
    );
  }

  _createWeekCards(weekList) {
    List<Widget> week = [];

    if (weekList.length < 7) {
      double width = MediaQuery.of(context).size.width / 25;

      week.add(SizedBox(width: width));
      for (var item in weekList) {
        week.add(_createTasksCard(item));
        week.add(SizedBox(width: width));
      }

      return Row(mainAxisAlignment: MainAxisAlignment.start, children: week);
    }

    for (var i = 0; i < weekList.length; i++) {
      week.add(_createTasksCard(weekList[i]));
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: week);
  }

  _createMonthCards(List monthList) {
    print(monthList.sublist(2, 8));
    List month = <Widget>[
      SizedBox(
        height: 250,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: 2,
          ),
          Text(
            'Su',
            style: ts,
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            'Mo',
            style: ts,
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            'Tu',
            style: ts,
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            'We',
            style: ts,
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            'Th',
            style: ts,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            'Fr',
            style: ts,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            'Sa',
            style: ts,
          ),
          SizedBox(
            width: 2,
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      _createWeekCards(monthList.sublist(0, 7)),
      SizedBox(
        height: 6,
      ),
      _createWeekCards(monthList.sublist(7, 14)),
      SizedBox(
        height: 6,
      ),
      _createWeekCards(monthList.sublist(14, 21)),
      SizedBox(
        height: 6,
      ),
      _createWeekCards(monthList.sublist(21, 28)),
      SizedBox(
        height: 6,
      ),
      _createWeekCards(monthList.sublist(28)),
    ];

    return month;
  }

  // _sendGetRequest() async {
  //   var r = await Requests.get('http://192.168.1.32:5000/api/Task');
  //   r.raiseForStatus();
  //   var body = r.json();
  //   print(body['data']);
  //   setState(() {
  //     taskList = body['data'];
  //   });
  // }

  List<bool> booleanList = [false, false, false];

  Function _changeBoolean(i) {
    setState(() {
      for (var i = 0; i < booleanList.length; i++) {
        booleanList[i] = false;
      }
      booleanList[i] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
            color: darkGrayColor,
            child: Theme(
                data: ThemeData(
                  canvasColor: Colors.transparent,
                ),
                child: Column(children: _createMonthCards(dummyList)))),
        Container(
            padding: EdgeInsets.only(left: 20),
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              color: Colors.white,
            ),
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              //do a list of true false values for each listTile every time one is selected
              //all the values become false and the one that is slected will be true .
              createListTile('1', booleanList, 0, _changeBoolean),
              createListTile('2', booleanList, 1, _changeBoolean),
              createListTile('3', booleanList, 2, _changeBoolean),
            ])),
      ],
    );
  }

  // void _onReorder(int oldIndex, int newIndex) {
  //   setState(
  //     () {
  //       if (newIndex > oldIndex) {
  //         newIndex -= 1;
  //       }
  //       final IntrayTodo item = list.removeAt(oldIndex);
  //       list.insert(newIndex, item);
  //     },
  //   );
  // }

  // void _createTaskList() {
  //   for (int i = 0; i < 10; i++) {
  //     taskList.add(Task(
  //       'task have to do ' + '${i + 1}',
  //       false,
  //       '$i',
  //     ));
  //   }
  // }

  // List<Widget> _getList() {
  //   print("taskList = " + taskList.toString());
  //   if (taskList.isNotEmpty) {
  //     if (list.length == 1) {
  //       list = [];
  //       for (int i = 0; i < taskList.length; i++) {
  //         list.add(IntrayTodo(
  //           key: ValueKey(taskList[i]["id"]),
  //           title: taskList[i]['task'],
  //           numb: i + 1,
  //         ));
  //       }
  //     }
  //   } else {
  //     list = [
  //       Container(
  //           key: ValueKey('1'),
  //           height: 100,
  //           color: Colors.red,
  //           alignment: Alignment.center,
  //           child: Text(
  //             'not loaded yet',
  //           ))
  //     ];
  //   }

  //   print("list = " + list.toString());

  //   return list;
  // }
}
