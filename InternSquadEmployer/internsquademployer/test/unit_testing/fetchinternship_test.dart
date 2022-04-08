import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internsquademployer/models/internship.dart';
import 'package:internsquademployer/provider/internship_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'fetchinternship_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Fetch individual internship', () {
    test('Returns a internship if http call completes successfully', () async {
      String baseUrl = 'http://192.168.1.73:90/';
      final client = MockClient();
      String id = '62036c1bd6478f72877c64e9';
      when(client.get(
              Uri.parse(baseUrl + 'internship/viewindividualinternship/' + id),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
              '{"id":"62036c1bd6478f72877c64e9","title":"Helpless","workEnvironment":"Office","startDate":"2020-01-01","duration":"5","stipend":"1000","deadline":"2020-00-00","internshipDetails":"bsdhdghc","skills":"bdjhdu","whoCanApply":"ckcmkowed","perks":"ebjdeh","numberOfOpenings":"4","department":"IT","internshipType":"PartTime"}',
              200));
      expect(await InternshipProvider().getIndividualInternship(id, client),
          isA<Map>());
    });
  });
}
