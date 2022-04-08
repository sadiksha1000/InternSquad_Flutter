import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:internsquademployer/provider/employer_provider.dart';
import 'package:internsquademployer/response/blog_response.dart';
import '../models/blog.dart';

class BlogProvider with ChangeNotifier {
  // String baseUrl = 'http://10.0.2.2:90/';
  String baseUrl = 'http://192.168.1.73:90/';

  String token = EmployerProvider.token;
  List<Blog> blogs = [];

  Future<List<Blog>> getBlogs() async {
    // print("BlogProvider");
    final response = await http.get(Uri.parse(baseUrl + 'resources/viewall'));
    // print("BlogProviderko ${response.statusCode}");
    if (response.statusCode == 200) {
      // print('Done');
      var data = jsonDecode(response.body);
      print(data);
      var a = BlogResponse.fromJson(data);
      // print("here");
      // print('BlogResponse ${a}');
      blogs = a.blog;
      notifyListeners();
      return a.blog;
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  setBlogs() async {
    blogs = await getBlogs();
    notifyListeners();
  }

  Future<bool> postBlogs(Blog blog) async {
    Map<String, dynamic> blogData = {
      "title": blog.title,
      "description": blog.description,
      "uploadDate": blog.uploadDate
    };

    String mytoken = 'Bearer $token';

    final response = await http
        .post(Uri.parse(baseUrl + 'blog/post'), body: blogData, headers: {
      'Authorization': mytoken,
    });
    print("BlogResponse${response.body}");
    if (response.statusCode == 200) {
      final blogData = jsonDecode(response.body) as Map;
      final success = blogData['success'];
      // var blogResponse = BlogResponse.fromJson(jsonDecode(response.body));
      return success!;
    } else {
      return false;
    }
  }

  Blog findById(String id) {
    print(blogs);
    return blogs.firstWhere((blog) => blog.id == id);
  }

  Future<bool> deleteBlog(String id, Client client) async {
    String mytoken = 'Bearer $token';

    final response = await client
        .delete(Uri.parse(baseUrl + 'resources/delete/' + id), headers: {
      'Authorization': mytoken,
    });
    print('BlogDeleteResponse${response.body}');
    if (response.statusCode == 200) {
      final blogData = jsonDecode(response.body) as Map;
      final success = blogData['success'];
      return success!;
    } else {
      return false;
    }
  }

  Future<bool> updateBlog(Blog blog, String id) async {
    Map<String, dynamic> blogData = {
      "title": blog.title,
      "description": blog.description,
      "uploadDate": blog.uploadDate
    };

    String mytoken = 'Bearer $token';

    final response = await http.put(
        Uri.parse(baseUrl + 'resources/update/' + id),
        body: blogData,
        headers: {
          'Authorization': mytoken,
        });
    if (response.statusCode == 200) {
      final blogData = jsonDecode(response.body) as Map;
      final success = blogData['success'];
      // var blogResponse = BlogResponse.fromJson(jsonDecode(response.body));
      return success!;
    } else {
      return false;
    }
  }
}
