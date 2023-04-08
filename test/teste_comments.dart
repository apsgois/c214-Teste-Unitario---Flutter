import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../lib/main.dart';
import 'teste_comments.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('TodoList', () {
    test('Teste retorna uma lista de comentarios', () async {
      final client = MockClient();

      when(client.get(
              Uri.parse('https://jsonplaceholder.typicode.com/comments/1')))
          .thenAnswer((_) async => http.Response(
              '{"postId": 1, "id": 1, "name": "id labore ex et quam laborum"}',
              200));

      final todoList = TodoList(client: client);

      //expect(() => todoList.fetchComments, throwsException);
      // await todoList.fetchComments();
      // expect(todoList.todoItems.length, equals(1));
      // expect(todoList.todoItems[0], equals('id labore ex et quam laborum'));
    });

    test('Colcoar a exception caso tenha algum erro ', () async {
      var mockClient = MockClient();
      when(mockClient
              .get(Uri.parse('https://jsonplaceholder.typicode.com/comments')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final todoList = TodoList(client: mockClient);
      expect(todoList.fetchComments, throwsException);
    });
  });
}
