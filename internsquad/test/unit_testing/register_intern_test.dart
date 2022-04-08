import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internsquad/models/intern.dart';
import 'package:internsquad/providers/intern_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'register_intern_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('registerIntern', () {
    test('Returns a success message if intern is registered', () async {
      String baseUrl = 'http://192.168.1.73:90/';
      Intern internData = Intern(
          fullName: "Franceska",
          address: "Pokhara",
          email: "fransceska@gmail.com",
          phone: "871632178351",
          password: "steviepie");
      final internMap = internData.toJson();
      internMap.removeWhere((key, value) => key == "_id");
      internMap.removeWhere((key, value) => key == "image");
      internMap.removeWhere((key, value) => key == "resume");
      print("EmployerMap$internMap");
      final client = MockClient();
      when(client.post(
        Uri.parse(baseUrl + 'intern/register'),
        body: internMap,
      )).thenAnswer((_) async => http.Response(
          '{"user":"intern","success":true,"message":"Registered Successfully!!!"}',
          200));
      expect(
        await InternProvider().registerIntern(internData, client),
        isA<bool>(),
      );
    });
  });
}
