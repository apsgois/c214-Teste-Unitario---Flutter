import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Lista de Tarefas',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();

  List<String> get todoItems => _TodoListState().todoItems;
}

class _TodoListState extends State<TodoList> {
  late final List<String> _todoItems;

  _TodoListState() {
    _todoItems = [];
  }

  List<String> get todoItems => _todoItems;

  BuildContext _getContext() {
    final navigatorKey = GlobalKey<NavigatorState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final context = scaffoldKey.currentContext ?? navigatorKey.currentContext;
    if (context == null) {
      throw Exception('Could not get context');
    }
    return context;
  }

  void addTodoItem(String item) {
    setState(() {
      _todoItems.add(item);
    });
    ScaffoldMessenger.of(_getContext()).showSnackBar(
      SnackBar(
        content: Text('Item adicionado: $item'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: _todoItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_todoItems[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTodoItem('Nova tarefa'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
