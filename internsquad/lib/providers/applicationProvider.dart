import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:internsquad/models/application.dart';
import 'package:internsquad/providers/intern_provider.dart';
import 'package:internsquad/response/application_response.dart';

class ApplicationProvider with ChangeNotifier {
  // String baseUrl = 'http://10.0.2.2:90/';
  String baseUrl = 'http://192.168.1.73:90/';
  String token = InternProvider.token;
  List<Application> applications = [];

  Future<bool> postApplication(
      Map<String, dynamic> application, Client client) async {
    // Map<String, dynamic> applicationData = {
    //   "internshipId": appplication.internshipId
    // };
    String mytoken = 'Bearer $token';

    final response = await client.post(Uri.parse(baseUrl + 'application/post'),
        body: application,
        headers: {
          'Authorization': mytoken,
        });
    if (response.statusCode == 200) {
      var applicationResponse = jsonDecode(response.body) as Map;
      return applicationResponse['success']!;
    } else {
      return false;
    }
  }

  Future<List<Application>> getMyApplication() async {
    String mytoken = 'Bearer $token';
    final response = await http
        .get(Uri.parse(baseUrl + 'application/viewmyapplication'), headers: {
      'Authorization': mytoken,
    });
    notifyListeners();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Hello");
      print("PostingApplicationResponse${data}");
      var a = ApplicationResponse.fromJson(data);
      // print("A: ${a}");
      print(a.application);
      return a.application;
    } else {
      throw Exception('Failed to load application');
    }
  }

  Future<bool> deleteApplication(String id) async {
    String mytoken = 'Bearer $token';

    final response = await http
        .delete(Uri.parse(baseUrl + 'application/delete/' + id), headers: {
      'Authorization': mytoken,
    });
    notifyListeners();
    if (response.statusCode == 200) {
      final applicationData = jsonDecode(response.body) as Map;
      final success = applicationData['success'];
      return success!;
    } else {
      return false;
    }
  }
}
