import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:internsquad/models/intern.dart';
import 'package:internsquad/persistent_database/sharedpreferences.dart';
import 'package:internsquad/response/intern_response.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class InternProvider with ChangeNotifier {
  // String baseUrl = 'http://10.0.2.2:90/';
  String baseUrl = 'http://192.168.1.73:90/';
  static String token = '';

  // Intern Registration Function
  Future<bool> registerIntern(Intern intern, Client client) async {
    Map<String, dynamic> internData = {
      "fullName": intern.fullName,
      "email": intern.email,
      "phone": intern.phone,
      "address": intern.address,
      "password": intern.password,
    };
    final response = await client.post(Uri.parse(baseUrl + 'intern/register'),
        body: internData);
    // print("Response ${response}");
    // print("Response Body${response.body}");
    if (response.statusCode == 200) {
      var internResponse = InternResponse.fromJson(jsonDecode(response.body));
      // print("Status${internResponse.success}");
      return internResponse.success!;
    } else {
      return false;
    }
  }

  // Intern login
  Future<bool> loginIntern(String email, String password, Client client) async {
    Map<String, dynamic> intern = {
      'email': email,
      'password': password,
    };

    try {
      final response =
          await client.post(Uri.parse(baseUrl + 'intern/login'), body: intern);
      final jsonData = jsonDecode(response.body) as Map;
      token = jsonData['token'];
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
    Map<String, dynamic> intern = {};

    try {
      final response =
          await get(Uri.parse(baseUrl + 'intern/viewprofile'), headers: {
        'Authorization': mytoken,
      });
      var internResponse = InternResponse.fromJson(jsonDecode(response.body));

      intern = internResponse.intern as Map<String, dynamic>;
      Map<String, dynamic> internVal = {
        "fullName": intern['fullName'],
        "email": intern['email'],
        "phone": intern['phone'],
        "address": intern['address'],
      };
    } catch (err) {
      print(err);
    }
    return intern;
  }

  Future<String> uploadImage(String filepath, String id) async {
    try {
      String route = 'intern/updateimage';
      String url = baseUrl + route;
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      //using the token in the headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      // need a filename
      var ss = filepath.split('/').last;
      // adding the file in the request
      request.files.add(
        http.MultipartFile(
          'file',
          File(filepath).readAsBytes().asStream(),
          File(filepath).lengthSync(),
          filename: ss,
        ),
      );
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

  void updateIntern(Intern intern, File? file) async {
    Map<String, dynamic> internData = {
      'fullName': intern.fullName,
      'email': intern.email,
      'address': intern.address,
      'phone': intern.phone,
    };

    String mytoken = 'Bearer $token';
    try {
      final response = await http.put(
          Uri.parse(baseUrl + 'intern/updateprofile'),
          body: internData,
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
    Map<String, dynamic> internPassword = {'password': password};

    String mytoken = 'Bearer $token';
    try {
      final response = await http.put(
          Uri.parse(baseUrl + 'intern/updateprofile'),
          body: internPassword,
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
      }
    } catch (err) {
      print(err);
    }
  }
}
