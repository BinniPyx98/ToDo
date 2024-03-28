import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List toDoList = [];
  String _taskName =''; // For add new item
  @override
  void initState() {
    toDoList.addAll(['1', '2', '3']);
    super.initState();
  }

  void removeTask(index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  void addTask(taskName){
    setState((){
      toDoList.add(taskName);
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('To do list'), centerTitle: true),
        backgroundColor: Colors.grey[900],
        body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return Dismissible(
                key: Key(toDoList[index]),
                child: Card(
                  child: ListTile(
                    title: Text('${toDoList[index]}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_sweep, color: Colors.orange),
                      onPressed: () {
                        removeTask(index);
                      },
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  removeTask(index);
                });
          },
        ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(title: const Text('Add item'),content: TextField(onChanged: (String value){
            _taskName = value;
          }), actions: [ElevatedButton(onPressed: (){
            addTask(_taskName);
            Navigator.of(context).pop();
          }, child: const Text('Add'))]);
        });
      },
      child: const Icon(Icons.add_circle_outline, color: Colors.green,),
    ),);
  }
}
