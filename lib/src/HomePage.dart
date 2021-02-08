import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'employee.dart';
import 'dart:async';
import 'DBHelper.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  //
  Future<List<Employee>> employees;
  TextEditingController controller = TextEditingController();
  String name;
  int curUserId;

  final formKey = new GlobalKey<FormState>();
  final formKey1 = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      employees = dbHelper.getEmployees();
    });
  }

  clearName() {
    controller.text = '';
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Employee e = Employee(curUserId, name);
        dbHelper.update(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        Employee e = Employee(null, name);
        dbHelper.save(e);
      }
      clearName();
      refreshList();
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => name = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: validate,
                  child: Text(isUpdating ? 'UPDATE' : 'ADD'),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    clearName();
                  },
                  child: Text('CANCEL'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dataTable(List<Employee> employees) {
    return ListView.builder(
        itemCount: employees.reversed.length,
        itemBuilder: (context, int index) {
          return Dismissible(
            key: Key("${employees[index].name}"),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                dbHelper.delete(employees[index].id);
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                        " user ${employees[index].name ?? ""} Completed")));
              } else if (direction == DismissDirection.endToStart) {
                dbHelper.delete(employees[index].id);
                Scaffold.of(context).showSnackBar(SnackBar(
                    content:
                        Text(" user ${employees[index].name ?? ""} Deleted")));
              }
            },
            // direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.done),
                  Text(
                    "Completed",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.delete),
                    Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            child: Card(
              color: Colors.amberAccent,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "${employees[index].name}",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curUserId = employees[index].id;
                      });
                      controller.text = employees[index].name;
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }


  list() {
    return Expanded(
      child: FutureBuilder(
        future: employees,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No Data Found");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Swipe data '),
      ),
   //    floatingActionButton: FloatingActionButton(onPressed: () {
   //     print("button press working");
   //   }),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            form(),
            list(),
          ],
        ),
      ),
    );
  }

  
  // void onReorder(int oldIndex, int newIndex) {
  //   if (newIndex > oldIndex) {
  //     newIndex -= 1;
  //   }

  //   setState(() {
  //     String game = topTenGames[oldIndex];

  //     topTenGames.removeAt(oldIndex);
  //     topTenGames.insert(newIndex, game);
  //   });
  // }

  // List<String> topTenGames = [
  //   "World of Warcraft",
  //   "Final Fantasy VII",
  //   "Animal Crossing",
  //   "Diablo II",
  //   "Overwatch",
  //   "Valorant",
  //   "Minecraft",
  //   "Dota 2",
  //   "Half Life 3",
  //   "Grand Theft Auto: Vice City"
  // ];

  // Widget dataTable(List<Employee> employees) {
  //   return ReorderableListView(
  //     onReorder: onReorder,
  //     children: getListItems(),
  //   );
  // }

  // List<ListTile> getListItems() => topTenGames
  //     .asMap()
  //     .map((i, item) => MapEntry(i, buildTenableListTile(item, i)))
  //     .values
  //     .toList();

  // ListTile buildTenableListTile(String item, int index) {
  //   return ListTile(
  //     key: ValueKey(item),
  //     title: Text(item),
  //     leading: Text("#${index + 1}"),
  //   );
  // }

}
