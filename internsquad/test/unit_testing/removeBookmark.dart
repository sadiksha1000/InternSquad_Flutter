import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internsquad/providers/bookmarkProvider.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'removeBookmark.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Remove bookmark', () {
    test('Returns a message that bookmark is removed', () async {
      String baseUrl = 'http://192.168.1.73:90/';
      final client = MockClient();
      String id = '1';
      when(client.delete(Uri.parse(baseUrl + 'bookmark/delete/' + id),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
              '{"success":true,"message":"Bookmark Deleted!!!"}', 200));
      expect(await BookMarkProvider().deleteBookmark(id, client), isA<bool>());
    });
  });
}
