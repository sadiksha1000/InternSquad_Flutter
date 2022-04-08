import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:internsquad/models/bookmark.dart';
import 'package:internsquad/providers/intern_provider.dart';
import 'package:internsquad/response/bookmark_response.dart';

class BookMarkProvider with ChangeNotifier {
  // String baseUrl = 'http://10.0.2.2:90/';
  String baseUrl = 'http://192.168.1.73:90/';
  String token = InternProvider.token;
  List<Bookmark> bookmarks = [];

  Future<bool> bookmarkInternship(Map<String, dynamic> bookmark) async {
    // Map<String, dynamic> bookmarkData = {"internshipId": bookmark.internshipId};
    String mytoken = 'Bearer $token';

    final response = await http
        .post(Uri.parse(baseUrl + 'bookmark/post'), body: bookmark, headers: {
      'Authorization': mytoken,
    });
    if (response.statusCode == 200) {
      var bookmarkResponse = jsonDecode(response.body) as Map;
      return bookmarkResponse['success']!;
    } else {
      return false;
    }
  }

  Future<List<Bookmark>> getMyBookmarks() async {
    String mytoken = 'Bearer $token';
    final response =
        await http.get(Uri.parse(baseUrl + 'bookmark/viewbookmark'), headers: {
      'Authorization': mytoken,
    });
    notifyListeners();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("PostingBookmarkResponse${data}");
      var a = BookmarkResponse.fromJson(data);
      // print("A: ${a}");
      print(a.bookmark);
      return a.bookmark;
    } else {
      throw Exception('Failed to load bookmarks');
    }
  }

  Future<bool> deleteBookmark(String id, Client client) async {
    String mytoken = 'Bearer $token';

    final response = await client
        .delete(Uri.parse(baseUrl + 'bookmark/delete/' + id), headers: {
      'Authorization': mytoken,
    });
    notifyListeners();
    if (response.statusCode == 200) {
      final bookmarkData = jsonDecode(response.body) as Map;
      final success = bookmarkData['success'];
      return success!;
    } else {
      return false;
    }
  }
}
