import 'dart:convert';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:internsquademployer/database/database_instance.dart';
import 'package:internsquademployer/entity/internship.dart';
import 'package:internsquademployer/models/internship.dart';
import 'package:internsquademployer/provider/employer_provider.dart';
import 'package:internsquademployer/response/internship_response.dart';

class InternshipProvider with ChangeNotifier {
  // String baseUrl = 'http://10.0.2.2:90/';
  String baseUrl = 'http://192.168.1.73:90/';

  String token = EmployerProvider.token;
  List<Internship> internships = [];

  // Post internship
  Future<bool> postInternship(Internship internship, Client client) async {
    Map<String, dynamic> internshipData = {
      "title": internship.title,
      "workEnvironment": internship.workEnvironment,
      "deadline": internship.deadline,
      "internshipType": internship.internshipType,
      "startDate": internship.startDate,
      "duration": internship.duration,
      "stipend": internship.stipend,
      "department": internship.department,
      "internshipDetails": internship.internshipDetails,
      "skills": internship.skills,
      "whoCanApply": internship.whoCanApply,
      "perks": internship.perks,
      "numberOfOpenings": internship.numberOfOpenings,
    };

    String mytoken = 'Bearer $token';
    // print('Token ${token}');
    // print(internship.title);
    // print(internship.workEnvironment);
    // print(internship.startDate);
    // print(internship.duration);
    // print(internship.stipend);
    // print(internship.deadline);
    // print(internship.internshipDetails);
    // print(internship.skills);
    // print(internship.whoCanApply);
    // print(internship.perks);
    // print(internship.numberOfOpenings);

    print(internshipData);

    final response = await client.post(Uri.parse(baseUrl + 'internship/post'),
        body: internshipData,
        headers: {
          'Authorization': mytoken,
        });
    print(response.body);
    if (response.statusCode == 200) {
      var internshipResponse = jsonDecode(response.body) as Map;
      print(internshipResponse['success']);
      return internshipResponse['success']!;
    } else {
      return false;
    }
  }

  Future<List<Internship>> getInternships(Client client) async {
    final response = await client.get(Uri.parse(baseUrl + 'internship/view'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("GetResponse${data}");
      var a = InternshipResponse.fromJson(data);
      internships = a.internship;
      notifyListeners();
      return a.internship;
    } else {
      throw Exception('Failed to load internships');
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

  setInternships() async {
    internships = await getInternships(Client());
    print("SetInternships${internships}");
    notifyListeners();
  }

  Internship findById(String id) {
    // setInternships();
    print("Internshipspsppps$internships");
    return internships.firstWhere((internship) => internship.id == id);
  }

  Future<bool> deleteInternship(String id) async {
    String mytoken = 'Bearer $token';

    final response = await http
        .delete(Uri.parse(baseUrl + 'internship/delete/' + id), headers: {
      'Authorization': mytoken,
    });

    if (response.statusCode == 200) {
      final internshipData = jsonDecode(response.body) as Map;
      final success = internshipData['success'];
      return success!;
    } else {
      return false;
    }
  }

  Future<bool> updateInternship(Internship internship, String id) async {
    Map<String, dynamic> internshipData = {
      "title": internship.title,
      "workEnvironment": internship.workEnvironment,
      "deadline": internship.deadline,
      "internshipType": internship.internshipType,
      "startDate": internship.startDate,
      "duration": internship.duration,
      "stipend": internship.stipend,
      "department": internship.department,
      "internshipDetails": internship.internshipDetails,
      "skills": internship.skills,
      "whoCanApply": internship.whoCanApply,
      "perks": internship.perks,
      "numberOfOpenings": internship.numberOfOpenings,
    };

    String mytoken = 'Bearer $token';

    final response = await http.put(
        Uri.parse(baseUrl + 'internship/update/' + id),
        body: internshipData,
        headers: {
          'Authorization': mytoken,
        });
    if (response.statusCode == 200) {
      final internship = jsonDecode(response.body) as Map;
      final success = internship['success'];
      return success!;
    } else {
      return false;
    }
  }

  Future<List<Internship>> getMyPosting() async {
    String mytoken = 'Bearer $token';
    final response = await http
        .get(Uri.parse(baseUrl + 'internship/viewmyposting'), headers: {
      'Authorization': mytoken,
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("PostingResponse${data}");
      var a = InternshipResponse.fromJson(data);
      print("A: ${a}");
      print(a.internship);
      return a.internship;
    } else {
      throw Exception('Failed to load internships');
    }
  }

  Future<Map> getIndividualInternship(String id, Client client) async {
    String mytoken = 'Bearer $token';
    final response = await client.get(
        Uri.parse(baseUrl + 'internship/viewindividualinternship/' + id),
        headers: {
          'Authorization': mytoken,
        });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as Map;
      print("Data$data");
      return data;
    } else {
      throw Exception('Failed to load internship');
    }
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
}
