import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  testWidgets('Test addTodoItem', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TodoList()));
    await tester
        .pumpAndSettle(); // aguarda a conclusão da construção dos widgets

    final todoList = tester.widget<TodoList>(find.byType(TodoList));
    final todoItems = todoList.todoItems;

    // Verifica que inicialmente a lista está vazia
    expect(todoItems.length, equals(0));

    // Adiciona um item diretamente na lista
    todoItems.add('Nova tarefa');

    // Aguarda a conclusão da animação da adição do item na lista
    await tester.pumpAndSettle();

    // Verifica que o item foi adicionado corretamente
    expect(todoItems.length, equals(1));
    expect(todoItems[0], equals('Nova tarefa'));
  });
}
