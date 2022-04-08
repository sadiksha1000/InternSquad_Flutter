import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:internsquad/response/blog_response.dart';
import '../models/blog.dart';

class BlogProvider with ChangeNotifier {
  // String baseUrl = 'http://10.0.2.2:90/';
  String baseUrl = 'http://192.168.1.73:90/';

  Future<List<Blog>> getBlogs() async {
    final response = await http.get(Uri.parse(baseUrl + 'resources/viewall'));
    print("BlogProviderko ${response.statusCode}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var a = BlogResponse.fromJson(data);
      print('BlogResponse ${a}');
      return a.blog;
    } else {
      throw Exception('Failed to load blogs');
    }
  }
}
