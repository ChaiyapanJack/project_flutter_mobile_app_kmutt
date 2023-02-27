// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}

void main() {
  runApp(
    MaterialApp(
      title: 'Passing Data',
      home: TodosScreen(
        todos: List.generate(
          10,
          (i) => Todo(
            'Todo $i',
            'A description of what needs to be done for Todo $i',
          ),
        ),
      ),
    ),
  );
}

class TodosScreen extends StatelessWidget {
  TodosScreen({super.key, required this.todos});

  final List<Todo> todos;

  final DateSearchController = TextEditingController();

  void clearText() {
    print('Clear');
    DateSearchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(5)));

    return Scaffold(
      appBar: AppBar(
        title:
            Text("Search Trand Twitter", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 183, 236, 123),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Search',
                        border: border,
                        errorBorder: border,
                        disabledBorder: border,
                        focusedBorder: border,
                        focusedErrorBorder: border,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: clearText,
                        ),
                      ),
                      controller: DateSearchController,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 12, 147, 16),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(10))),
                    child: IconButton(
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todos[index].title),
                    // When a user taps the ListTile, navigate to the DetailScreen.
                    // Notice that you're not only creating a DetailScreen, you're
                    // also passing the current todo through to it.
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(todo: todos[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailScreen({super.key, required this.todo});

  // Declare a field that holds the Todo.
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(todo.description),
      ),
    );
  }
}
