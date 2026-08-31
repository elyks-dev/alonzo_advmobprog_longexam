import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models.dart';
import '../models/comment.dart';

class CommentService {
  static const host = 'https://dummyjson.com';

  Future<List<CommentModel>> getCommentsByPost(int postId) async {
    final response = await http.get(Uri.parse('$host/comments/post/$postId'));

    if (response.statusCode != 200) {
      throw Exception('Unable to load comments');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return (data['comments'] as List)
        .map((e) => CommentModel.fromJson(e))
        .toList();
  }

  Future<List<Comment>> getComments(int postId) async {
    final response = await http.get(Uri.parse('$host/comments/post/$postId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load comments');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return (data['comments'] as List)
        .map((item) => Comment.fromJson(item))
        .toList();
  }

  Future<CommentModel> addComment({
    required int postId,
    required int userId,
    required String body,
  }) async {
    final response = await http.post(
      Uri.parse('$host/comments/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'body': body,
        'postId': postId,
        'userId': userId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add comment');
    }

    return CommentModel.fromJson(jsonDecode(response.body));
  }
}