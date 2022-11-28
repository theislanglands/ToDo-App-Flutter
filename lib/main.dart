import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do or not To Do',
      theme: ThemeData(
        // theme of the application.
        brightness: Brightness.light,
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(title: 'To Do or not To Do'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _todos = ['Buy Milk', 'Feed cat', 'Do washing'];
  List<String> _dones = ['done nr1', 'done 2'];
  final todoInputField = TextEditingController();

  void _addTodo(String todo) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method
      _todos.add(todo);
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
      print("delete fkt");
    });
  }

  void _done(int index) {
    setState(() {
      _dones.add(_todos.elementAt(index));
      _todos.removeAt(index);
    });
  }

  void _deleteDone(int index) {
    setState(() {
      _dones.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: todoInputField,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'enter your to-do',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add_box_rounded),
                        tooltip: "add",
                        onPressed: () {
                          _addTodo(todoInputField.text);
                          todoInputField.clear();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Text('Todo\'s', style: TextStyle(fontSize: 25)),
            ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: _todos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Card(
                      color: Colors.blueGrey[200 + (index % 2)],
                      child: ListTile(
                        title: Text(
                          textAlign: TextAlign.left,
                          _todos[index],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_rounded),
                          tooltip: "delete",
                          onPressed: () {
                            _deleteTodo(index);
                          },
                        ),
                      ),
                    ),
                  );
                }),
            const Text('Done\'s', style: TextStyle(fontSize: 25)),
            ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: _dones.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Card(
                      color: Colors.blueGrey[200 + (index % 2)],
                      child: ListTile(
                        title: Text(
                          textAlign: TextAlign.left,
                          _dones[index],
                          style: const TextStyle(decoration: TextDecoration.lineThrough),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_rounded),
                          tooltip: "delete",
                          onPressed: () {
                            _deleteDone(index);
                          },
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
