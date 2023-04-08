import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../lib/main.dart';
import 'test_testComents.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('TodoList', () {
    test('Teste retorna uma lista de comentarios', () async {
      // Create a MockClient using the Mockito package.
      // Create new instances of this class in each test.
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
              Uri.parse('https://jsonplaceholder.typicode.com/comments/1')))
          .thenAnswer((_) async => http.Response(
              '{"postId": 1, "id": 1, "name": "id labore ex et quam laborum"}',
              200));

      final todoList = TodoList(client: client);
      await todoList.fetchComments;
      expect(todoList.todoItems.length, equals(1));
      expect(todoList.todoItems[0], equals('id labore ex et quam laborum'));
    });
  });
}
