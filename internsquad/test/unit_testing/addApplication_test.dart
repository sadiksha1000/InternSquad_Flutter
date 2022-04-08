import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internsquad/models/application.dart';
import 'package:internsquad/models/intern.dart';
import 'package:internsquad/models/internship.dart';
import 'package:internsquad/providers/applicationProvider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'addApplication_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Add new internship', () {
    test('Returns a success message if application is posted', () async {
      String baseUrl = 'http://192.168.1.73:90/';
      Application applicationData =
          Application(id: '', internId: Intern(), internshipId: Internship());
      final applicationMap = applicationData.toJson();
      // internshipMap.removeWhere((key, value) => key == "_id");
      // internshipMap.removeWhere((key, value) => key == "companyName");
      // internshipMap.removeWhere((key, value) => key == "companyProfile");
      // internshipMap.removeWhere((key, value) => key == "address");
      // internshipMap.removeWhere((key, value) => key == "email");
      // internshipMap.removeWhere((key, value) => key == "phone");
      // internshipMap.removeWhere((key, value) => key == "image");
      // internshipMap.removeWhere((key, value) => key == "emp");
      print("InternshipMap$applicationMap");
      final client = MockClient();
      when(client.post(
        Uri.parse(baseUrl + 'application/post'),
        body: applicationMap,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async =>
          http.Response('{"success":true,"message":"Internship Posted"}', 200));
      expect(
        await ApplicationProvider().postApplication(applicationMap, client),
        isA<bool>(),
      );
    });
  });
}
