import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:internsquademployer/models/employer.dart';
import 'package:http/http.dart';
import 'package:internsquademployer/persistent_database/sharedpreferences.dart';
import 'package:internsquademployer/response/employer_response.dart';

class EmployerProvider with ChangeNotifier {
  // String baseUrl = 'http://10.0.2.2:90/';
  String baseUrl = 'http://192.168.1.73:90/';
  static String token = '';

  // Employer registration function
  Future<bool> registerEmployer(Employer employer, Client client) async {
    Map<String, dynamic> employerData = {
      "companyName": employer.companyName,
      "address": employer.address,
      "email": employer.email,
      "phone": employer.phone,
      "password": employer.password,
    };
    print("EmployerData$employerData");

    final response = await client.post(Uri.parse(baseUrl + 'employer/register'),
        body: employerData);
    print("Response${response.statusCode}");
    print("ResponseBody${response.body}");
    if (response.statusCode == 200) {
      var employerResponse =
          EmployerResponse.fromJson(jsonDecode(response.body));
      return employerResponse.success!;
    } else {
      return false;
    }
  }

  // Employer login
  Future<bool> loginEmployer(
      String email, String password, Client client) async {
    Map<String, dynamic> employer = {
      'email': email,
      'password': password,
    };
    print("Employer$employer");
    // final response = await client.post(
    //   Uri.parse(baseUrl + 'employer/login'),
    //   body: employer,
    // );
    // print("Response${response.statusCode}");
    // final jsonData = jsonDecode(response.body) as Map;
    // token = jsonData['token'];
    // print("Token$token");
    // print("JSON$jsonData");
    // if (token.isNotEmpty) {
    //   final pref = SharedPreferencesHelper().setAuthToken(token);
    //   return true;
    // } else {
    //   return false;
    // }
    try {
      final response = await client.post(Uri.parse(baseUrl + 'employer/login'),
          body: employer);
      print("Response$response");
      final jsonData = jsonDecode(response.body) as Map;
      token = jsonData['token'];
      print("Token$token");
      print("JSON$jsonData");
      if (token.isNotEmpty) {
        final pref = SharedPreferencesHelper().setAuthToken(token);
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err);
    }
    return false;
  }

  // View Profile
  Future<Map<String, dynamic>> viewProfile(String token) async {
    String mytoken = 'Bearer $token';
    Map<String, dynamic> employer = {};

    try {
      final response =
          await get(Uri.parse(baseUrl + 'employer/viewprofile'), headers: {
        'Authorization': mytoken,
      });
      print(response.body);
      var employerResponse =
          EmployerResponse.fromJson(jsonDecode(response.body));

      employer = employerResponse.employer as Map<String, dynamic>;
      print('Employer${employer}');
      // Map<String, dynamic> employerVal = {
      //   "companyName": employer['companyName'],
      //   "address": employer['address'],
      //   "email": employer['email'],
      //   "phone": employer['phone'],
      // };
    } catch (err) {
      print(err);
    }
    return employer;
  }

  Future<String> uploadImage(String filepath, String id) async {
    try {
      String route = 'employer/updateimage';
      String url = baseUrl + route;
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      //using the token in the headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      // need a filename
      var ss = filepath.split('/').last;
      print(ss);
      // adding the file in the request
      request.files.add(
        http.MultipartFile(
          'image',
          File(filepath).readAsBytes().asStream(),
          File(filepath).lengthSync(),
          filename: ss,
        ),
      );
      print("RequestFiles${request.files[0]}");
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      print('ImageResponse${responseString}');
      if (response.statusCode == 200) {
        print('reached');
        return responseString;
      }
    } catch (err) {
      print(err);
    }
    return 'something went wrong';
  }

  void updateEmployer(Employer emp, File? file) async {
    Map<String, dynamic> employer = {
      'companyName': emp.companyName,
      'companyProfile': emp.companyProfile,
      'email': emp.email,
      'address': emp.address,
      'phone': emp.phone,
    };

    String mytoken = 'Bearer $token';
    try {
      final response = await http.put(
          Uri.parse(baseUrl + 'employer/updateprofile'),
          body: employer,
          headers: {
            'Authorization': mytoken,
          });
      if (response.statusCode == 200) {
        if (file != null) {
          var jsonData = jsonDecode(response.body);
          uploadImage(file.path, jsonData['data']['_id']);
        }
        Fluttertoast.showToast(
          msg: "Profile updated successfully",
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
        );
        print('Data updated');
      }
    } catch (err) {
      print(err);
    }
  }

  void updatePassword(String password) async {
    Map<String, dynamic> employerPassword = {'password': password};

    String mytoken = 'Bearer $token';
    try {
      final response = await http.put(
          Uri.parse(baseUrl + 'employer/updateprofile'),
          body: employerPassword,
          headers: {
            'Authorization': mytoken,
          });
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Password updated successfully",
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
        );
        print('Data updated');
      }
    } catch (err) {
      print(err);
    }
  }
}
