import 'package:http/http.dart' as http;
import 'package:internsquademployer/provider/employer_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'login_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('loginEmployer', () {
    test('Returns a map response if Employer is logged in successfully',
        () async {
      String baseUrl = 'http://192.168.1.69:90/';
      final client = MockClient();
      when(client.post(
        Uri.parse(baseUrl + 'employer/login'),
        body: '{"email":"stellarsolutions@gmail.com","password":"dallu100@"}',
        headers: {
          'Content-Type': 'application/json',
        },
      ))
          // when(client.post(Uri.parse(baseUrl + 'employer/login'),
          //         body:
          //             '{"email":"stellarsolutions@gmail.com","password":"dallu100@"}'))
          .thenAnswer((_) async => http.Response(
              '{"user":"employer","success":true,"token":"a","message":"Auth Successful","name":"InterStellar Solutions"}',
              200));
      expect(
          await EmployerProvider()
              .loginEmployer("stellarsolutions@gmail.com", "dallu100@", client),
          isA<bool>());
    });
  });
}
