import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internsquademployer/models/application.dart';
import 'package:internsquademployer/provider/employer_provider.dart';
import 'package:internsquademployer/response/application_response.dart';

class ApplicationProvider with ChangeNotifier {
  // String baseUrl = 'http://10.0.2.2:90/';
  String baseUrl = 'http://192.168.1.73:90/';
  String token = EmployerProvider.token;
  List<Application> applications = [];

  Future<List<Application>> getMyApplicants() async {
    String mytoken = 'Bearer $token';
    final response = await http
        .get(Uri.parse(baseUrl + 'application/viewapplicants'), headers: {
      'Authorization': mytoken,
    });
    notifyListeners();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Hello");
      print("PostingApplicationResponse${data}");
      var a = ApplicationResponse.fromJson(data);
      print("Application$a");
      print(a.application);
      return a.application;
    } else {
      throw Exception('Failed to load application');
    }
  }
}
