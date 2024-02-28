import 'package:hive_flutter/adapters.dart';

class ToDoDataBase{
List toDoList =[];

//box reference
final _myBox =Hive.box('mybox');

//for 1st time, run this method
void createInitialData(){
  toDoList =[
    ["Do Exercise",false],
    ["Attend Workshop", false],
  ];
}

//load database
void loadData(){
 toDoList = _myBox.get("TODOLIST");
}


//update database
void updateDataBase(){
 _myBox.put("TODOLIST", toDoList);

}
}