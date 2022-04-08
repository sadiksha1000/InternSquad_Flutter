import 'package:http/http.dart' as http;
import 'package:internsquad/providers/intern_provider.dart';

import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'login_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('loginIntern', () {
    test('Returns a map response if Intern is logged in successfully',
        () async {
      String baseUrl = 'http://192.168.1.73:90/';
      final client = MockClient();
      when(client.post(
        Uri.parse(baseUrl + 'intern/login'),
        body:
            '{"email":"samjhanachitrakar@gmail.com","password":"Samjhana10@"}',
        headers: {
          'Content-Type': 'application/json',
        },
      )).thenAnswer((_) async => http.Response(
          '{"user":"intern","success":true,"token":"a","message":"Auth Successful","name":"Samjhana Chitrakar"}',
          200));
      expect(
          await InternProvider().loginIntern(
              "samjhanachitrakar@gmail.com", "Samjhana10@", client),
          isA<bool>());
    });
  });
}
