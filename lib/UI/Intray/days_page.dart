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
  List<Widget> list = new List<Widget>();
  List taskList = new List();
  @override
  void initState() {
    _sendGetRequest();
    super.initState();
  }

  _sendGetRequest() async {
    var r = await Requests.get('http://192.168.1.32:5000/api/Task');
    r.raiseForStatus();
    var body = r.json();
    print(body['data']);
    setState(() {
      taskList = body['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: darkGrayColor,
        child: Theme(
          data: ThemeData(
            canvasColor: Colors.transparent,
          ),
          child: ReorderableListView(
              onReorder: _onReorder,
              padding: EdgeInsets.only(top: 400),
              // controller: FixedExtentScrollController(),
              // physics: FixedExtentScrollPhysics(),

              children: _getList()
              // itemExtent: 60.0,
              ),
        ));
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final IntrayTodo item = list.removeAt(oldIndex);
        list.insert(newIndex, item);
      },
    );
  }

  // void _createTaskList() {
  //   for (int i = 0; i < 10; i++) {
  //     taskList.add(Task(
  //       'task have to do ' + '${i + 1}',
  //       false,
  //       '$i',
  //     ));
  //   }
  // }

  List<Widget> _getList() {
    print("taskList = " + taskList.toString());
    if (taskList.isNotEmpty) {
      if (list.length == 1) {
        list = [];
        for (int i = 0; i < taskList.length; i++) {
          list.add(IntrayTodo(
            key: ValueKey(taskList[i]["id"]),
            title: taskList[i]['task'],
            numb: i + 1,
          ));
        }
      }
    } else {
      list = [
        Container(
            key: ValueKey('1'),
            height: 100,
            color: Colors.red,
            alignment: Alignment.center,
            child: Text(
              'not loaded yet',
            ))
      ];
    }

    print("list = " + list.toString());

    return list;
  }
}
