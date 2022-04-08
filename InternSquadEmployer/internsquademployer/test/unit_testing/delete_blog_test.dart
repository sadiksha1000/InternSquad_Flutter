import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internsquademployer/provider/blog_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'delete_blog_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Delete blog', () {
    test('Returns a message that blog is deleted', () async {
      String baseUrl = 'http://192.168.1.73:90/';
      final client = MockClient();
      String id = '1';
      when(client.delete(Uri.parse(baseUrl + 'resources/delete/' + id),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
              '{"success":true,"message":"Resource Deleted!!!"}', 200));
      expect(await BlogProvider().deleteBlog(id, client), isA<bool>());
    });
  });
}
