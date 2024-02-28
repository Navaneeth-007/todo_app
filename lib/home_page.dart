// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>_HomePageState();
}
class _HomePageState extends State<HomePage>{
//reference hive box
final _myBox= Hive.box('mybox');
ToDoDataBase db = ToDoDataBase();

@override
void initState(){
  //1st time app opening,then default data
  if(_myBox.get("TODOLIST")==null){
    db.createInitialData();
  }
  else{
    //already data exists
    db.loadData();
  }
  //implement initstate
  super.initState();
}
//text controller
final _controller= TextEditingController();


//check box tapped
void checkBoxChanged(bool? value,int index){
  setState(() {
    db.toDoList[index][1]=!db.toDoList[index][1];
  });
  db.updateDataBase();
}

//saving new task
void saveNewTask(){
  setState(() {
    db.toDoList.add([_controller.text, false]);
    _controller.clear();
  });
   Navigator.of(context).pop();
   db.updateDataBase();
}

//creating new task
void createNewTask(){
  showDialog(
    context: context,
     builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      );
    },
  );
}

//deleting task
void deleteTask(int index){
  setState(() {
    db.toDoList.removeAt(index);
  });
  db.updateDataBase();
}

  @override
  Widget build(BuildContext context)
  {
       return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('TO DO'),
          elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: createNewTask,
            child: Icon(Icons.add),
            ),
          body: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index){
              return ToDoTile(
                onChanged: (value) => checkBoxChanged(value, index), 
                taskCompleted: db.toDoList[index][1], 
                taskName: db.toDoList[index][0],
                deleteFunction: (context) => deleteTask(index),
                );
            },

            
          ),
       );
  }
}
