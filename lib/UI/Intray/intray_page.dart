import 'package:flutter/material.dart';
import 'package:myapp1/models/classes/task.dart';
import 'package:myapp1/models/global.dart';
import 'package:myapp1/models/widgets/intrayTodo.dart';
import 'package:requests/requests.dart';

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  TextEditingController tasknameController = TextEditingController();
  TextEditingController timelimitController = TextEditingController();

  List<Widget> list = new List<Widget>();
  List taskList = new List();
  @override
  void initState() {
    setState(() {
      pageNum = 0;
    });
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

  void _sendpostRequest() async {
    var r = await Requests.post('http://192.168.1.32:5000/api/Task',
        body: {
          'task': tasknameController.text,
          'completed': false,
          'notes': '',
        },
        bodyEncoding: RequestBodyEncoding.JSON);

    // r.raiseForStatus();
    dynamic json = r.json();
    print(r.content());
    // print(json);

    if (json['status'] == 'true') {}
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: darkGrayColor,
          title: Align(
              alignment: Alignment.center, child: new Text("Add New Task")),
          titleTextStyle: TextStyle(color: redColor),
          content: Container(
            height: 180,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                      style: TextStyle(color: redColor),
                      cursorColor: redColor,
                      controller: tasknameController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: redColor),
                        hintText: 'Task Name',
                      )),
                  TextField(
                    style: TextStyle(color: redColor),
                    controller: timelimitController,
                    decoration: InputDecoration(
                      hintText: 'Time limit',
                      hintStyle: TextStyle(color: redColor),
                    ),
                  ),
                ]),
          ),
          actionsPadding: EdgeInsets.only(right: 35, left: 30, bottom: 15),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              color: redColor,
              child: new Text(
                "Cancel",
                style: TextStyle(color: darkGrayColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 30,
            ),
            new FlatButton(
              padding: EdgeInsets.only(left: 20, right: 20),
              color: redColor,
              child: new Text(
                "Add",
                style: TextStyle(
                  color: darkGrayColor,
                ),
              ),
              onPressed: () {
                _sendpostRequest();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      new Container(
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
          )),
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
          child: pageWidget[pageNum]),
      Container(
        height: 80,
        width: 80,
        margin: EdgeInsets.only(
            top: 90, left: MediaQuery.of(context).size.width * 0.5 - 40),
        child: FloatingActionButton(
          onPressed: () {
            _showDialog();
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 70,
          ),
          backgroundColor: redColor,
        ),
      )
    ]);
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
