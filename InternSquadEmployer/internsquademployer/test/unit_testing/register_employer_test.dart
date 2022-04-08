import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internsquademployer/models/employer.dart';
import 'package:internsquademployer/provider/employer_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'register_employer_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('registerEmployer', () {
    test('Returns a success message if employer is registered', () async {
      String baseUrl = 'http://192.168.1.73:90/';
      Employer employerData = Employer(
          companyName: "StarStocks",
          address: "Pokhara",
          email: "starstock@gmail.com",
          phone: "871632178351",
          password: "starbucks");
      final employerMap = employerData.toJson();
      employerMap.removeWhere((key, value) => key == "_id");
      employerMap.removeWhere((key, value) => key == "image");
      employerMap.removeWhere((key, value) => key == "companyProfile");
      print("EmployerMap$employerMap");
      final client = MockClient();
      when(client.post(
        Uri.parse(baseUrl + 'employer/register'),
        body: employerMap,
      )).thenAnswer((_) async => http.Response(
          '{"user":"employer","success":true,"message":"Registered Successfully!!!"}',
          200));
      expect(
        await EmployerProvider().registerEmployer(employerData, client),
        isA<bool>(),
      );
    });
  });
}
