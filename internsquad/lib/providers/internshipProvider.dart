import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internsquad/database/database_instance.dart';
import 'package:internsquad/entity/internship.dart';
import 'package:internsquad/models/internship.dart';
import 'package:internsquad/response/internship_response.dart';

class InternshipProvider with ChangeNotifier {
  // String baseUrl = 'http://10.0.2.2:90/';
  String baseUrl = 'http://192.168.1.73:90/';
  List<Internship> internships = [];

  Future<List<Internship>> getInternships() async {
    final response = await get(Uri.parse(baseUrl + 'internship/view'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Response${data}");
      var a = InternshipResponse.fromJson(data);
      internships = a.internship;
      print("Responseinternship$internships");
      notifyListeners();
      print("ResponseData ${a.internship}");
      return a.internship;
    } else {
      throw Exception('Failed to load internship');
    }
  }

  setInternships() async {
    internships = await getInternships();
    notifyListeners();
  }

  Internship findById(String id) {
    // print("idreached");
    // print("Idinternships$internships");
    // print(internships.firstWhere((internship) => internship.id == id));
    return internships.firstWhere((internship) => internship.id == id);
  }

  Future<List<Internship>> filterInternshipsByLocation(String address) async {
    final response =
        await get(Uri.parse(baseUrl + 'internship/address/' + address));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("ResponseData${data}");
      var a = InternshipResponse.fromJson(data);
      internships = a.internship;
      print("Responseinternship$internships");
      notifyListeners();
      print("ResponseData ${a.internship}");
      return a.internship;
    } else {
      throw Exception('Failed to load internship');
    }
  }

  Future<List<Internship>> filterInternshipsByDepartment(
      String department) async {
    final response =
        await get(Uri.parse(baseUrl + 'internship/industry/' + department));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("ResponseData${data}");
      var a = InternshipResponse.fromJson(data);
      internships = a.internship;
      print("Responseinternship$internships");
      notifyListeners();
      print("ResponseData ${a.internship}");
      return a.internship;
    } else {
      throw Exception('Failed to load internship');
    }
  }

  Future<List<Internship>> filterInternshipsByCategory(String category) async {
    final response =
        await get(Uri.parse(baseUrl + 'internship/category/' + category));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("ResponseData${data}");
      var a = InternshipResponse.fromJson(data);
      internships = a.internship;
      print("Responseinternship$internships");
      notifyListeners();
      print("ResponseData ${a.internship}");
      return a.internship;
    } else {
      throw Exception('Failed to load internship');
    }
  }

  Future<List<Internship>> filterInternshipsByEnvironment(
      String workEnvironment) async {
    final response = await get(
        Uri.parse(baseUrl + 'internship/environment/' + workEnvironment));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("ResponseData${data}");
      var a = InternshipResponse.fromJson(data);
      internships = a.internship;
      print("Responseinternship$internships");
      notifyListeners();
      print("ResponseData ${a.internship}");
      return a.internship;
    } else {
      throw Exception('Failed to load internship');
    }
  }

  Future<Map> getIndividualInternship(String id, Client client) async {
    // String mytoken = 'Bearer $token';
    final response = await client.get(
      Uri.parse(baseUrl + 'internship/viewindividualinternship/' + id),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as Map;
      print("Data$data");
      return data;
    } else {
      throw Exception('Failed to load internship');
    }
  }

  insertInternship(Internships internship) async {
    var internshipData = Internships(
        title: internship.title,
        workEnvironment: internship.workEnvironment,
        deadline: internship.deadline,
        startDate: internship.startDate,
        duration: internship.duration,
        stipend: internship.stipend,
        department: internship.department,
        eid: internship.eid,
        internshipDetails: internship.internshipDetails,
        internshipType: internship.internshipType,
        numberOfOpenings: internship.numberOfOpenings,
        perks: internship.perks,
        skills: internship.skills,
        whoCanApply: internship.whoCanApply,
        address: internship.address,
        companyName: internship.companyName,
        companyProfile: internship.companyProfile,
        email: internship.email,
        image: internship.image,
        phone: internship.phone);
    final database = await DatabaseInstance.instance.getDatabaseInstance();
    final result =
        await database.internshipDao.insertInternship(internshipData);
    print("DaoResultInsert$result");
  }

  Future<List<Internship>> getInternshipsOffline(Client client) async {
    final response =
        await client.get(Uri.parse(baseUrl + 'internship/viewoffline'));
    if (response.statusCode == 200) {
      Internships internshipsOffline;
      var data = jsonDecode(response.body);
      print("GetResponse${data}");
      var a = InternshipResponse.fromJson(data);
      for (var internshipPosting in a.internship) {
        internshipsOffline = Internships.fromJson(internshipPosting.toJson());
        insertInternship(internshipsOffline);
      }

      internships = a.internship;

      notifyListeners();
      return a.internship;
    } else {
      throw Exception('Failed to load internships');
    }
  }

  // Future<bool> applyInternship(String internshipId) async {
  //   final id = internshipId;
  //   final response =
  //       await post(Uri.parse(baseUrl + 'application/post'), body: id);
  //   if(response.statusCode==200){

  //   }
  // }
}
