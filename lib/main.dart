import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Lista de Tarefas',
      home: TodoList(client: http.Client()),
    );
  }
}

class TodoList extends StatefulWidget {
  final http.Client _client;

  const TodoList({Key? key, required http.Client client})
      : _client = client,
        super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
  List<String> get todoItems => _TodoListState().todoItems;
  Future<void> get fetchComments => _TodoListState().fetchComments();
}

class _TodoListState extends State<TodoList> {
  late final List<String> _todoItems;
  // late final Future<void> fetchComments;

  _TodoListState() {
    _todoItems = [];
    fetchComments();
  }

  Future<void> fetchComments() async {
    final response = await widget._client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _todoItems.addAll(data.map((e) => e['name'].toString()).toList());
      });
    } else {
      throw Exception('Failed to fetch comments');
    }
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
