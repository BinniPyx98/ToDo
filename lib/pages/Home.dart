import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List toDoList = [];
  String _taskName = ''; // For add new item
  @override
  void initState() {
    toDoList.addAll(['1', '2', '3']);
    super.initState();
  }

  void removeTask(taskId) {
    FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
    // setState(() {
    //   toDoList.removeAt(index);
    // });
  }

  void addTask(taskName) {
    setState(() {
      toDoList.add(taskName);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To do list'), centerTitle: true),
      backgroundColor: Colors.grey[900],
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) return Text('empty database');
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              String? taskId = snapshot.data?.docs[index].id;
              return Dismissible(
                  key: Key(taskId!),
                  child: Card(
                    child: ListTile(
                      title: Text('${snapshot.data?.docs[index].get('task')}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_sweep, color: Colors.orange),
                        onPressed: () {
                          removeTask(taskId);
                        },
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    removeTask(taskId);
                  });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text('Add item'),
                    content: TextField(onChanged: (String value) {
                      _taskName = value;
                    }),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            // addTask(_taskName);
                            // Navigator.of(context).pop();
                            FirebaseFirestore.instance.collection('tasks').add({'task':_taskName});
                          },
                          child: const Text('Add'))
                    ]);
              });
        },
        child: const Icon(
          Icons.add_circle_outline,
          color: Colors.green,
        ),
      ),
    );
  }
}
