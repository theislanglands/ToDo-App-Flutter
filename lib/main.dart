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

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> _todos_list = [
    Todo(content: "buy chesses"),
    Todo(content: "get drunk")
  ];
  final todoInputField = TextEditingController();

  void _addTodo(String todo) {
    setState(() { // reruns build method on state change
      _todos_list.add(Todo(content: todo));
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _todos_list.remove(todo);
    });
  }

  void _done(Todo todo) {
    setState(() {
      todo.isDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // title value from the HomePage object
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

            // todo section!
            const Text('Todo\'s', style: TextStyle(fontSize: 25)),
            ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: _todos_list
                    .where((element) => element.isDone == false)
                    .toList()
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  List<Todo> unDones = _todos_list
                      .where((todo) => todo.isDone == false)
                      .toList();
                  return Center(
                    child: Card(
                      color: Colors.blueGrey[200 + (index % 2)],
                      child: ListTile(
                        title: Text(
                          textAlign: TextAlign.left,
                          unDones[index].content,
                        ),
                        trailing: Wrap(
                          spacing: 8, // space between the icons
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.check_circle),
                              tooltip: "mark as done",
                              onPressed: () {
                                _done(unDones[index]);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_rounded),
                              tooltip: "delete",
                              onPressed: () {
                                _deleteTodo(unDones[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

            // done section
            const Text('Done\'s', style: TextStyle(fontSize: 25)),

            ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: _todos_list
                    .where((element) => element.isDone == true)
                    .toList()
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  List<Todo> dones =
                      _todos_list.where((todo) => todo.isDone == true).toList();

                  return Center(
                    child: Card(
                      color: Colors.blueGrey[200 + (index % 2)],
                      child: ListTile(
                        title: Text(
                          textAlign: TextAlign.left,
                          dones[index].content,
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_rounded),
                          tooltip: "delete",
                          onPressed: () {
                            _deleteTodo(dones[index]);
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

class Todo {
  String content;
  bool isDone = false;

  Todo({required this.content});
}
