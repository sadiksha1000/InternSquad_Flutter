import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internsquademployer/models/internship.dart';
import 'package:internsquademployer/provider/internship_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'add_internship_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Add new internship', () {
    test('Returns a success message if internship is posted', () async {
      String baseUrl = 'http://192.168.1.73:90/';
      Internship internshipData = Internship(
          title: "Helpless",
          workEnvironment: "Office",
          startDate: "2020-01-01",
          duration: "5",
          stipend: "10000",
          deadline: "2019-12-06",
          internshipDetails: "abcdcdc",
          skills: "ncd,bsdcjhc,cnbdnic",
          whoCanApply: "dnckejdke",
          perks: "dbeidj",
          numberOfOpenings: "4",
          department: "IT",
          internshipType: "PartTime");
      final internshipMap = internshipData.toJson();
      internshipMap.removeWhere((key, value) => key == "_id");
      internshipMap.removeWhere((key, value) => key == "companyName");
      internshipMap.removeWhere((key, value) => key == "companyProfile");
      internshipMap.removeWhere((key, value) => key == "address");
      internshipMap.removeWhere((key, value) => key == "email");
      internshipMap.removeWhere((key, value) => key == "phone");
      internshipMap.removeWhere((key, value) => key == "image");
      internshipMap.removeWhere((key, value) => key == "emp");
      print("InternshipMap$internshipMap");
      final client = MockClient();
      when(client.post(
        Uri.parse(baseUrl + 'internship/post'),
        body: internshipMap,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async =>
          http.Response('{"success":true,"message":"Internship Posted"}', 200));
      expect(
        await InternshipProvider().postInternship(internshipData, client),
        isA<bool>(),
      );
    });
  });
}
