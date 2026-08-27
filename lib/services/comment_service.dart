import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models.dart';
import '../models/comment.dart';

class CommentService {
  static const host = 'https://dummyjson.com';
  Future<List<CommentModel>> getCommentsByPost(int postId) async {
    final response = await http.get(Uri.parse('$host/comments/post/$postId'));
    if (response.statusCode != 200) throw Exception('Unable to load comments');
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return (data['comments'] as List)
        .map((e) => CommentModel.fromJson(e))
        .toList();
  }

  Future<List<Comment>> getComments(int postId) async {
    final response = await http.get(Uri.parse('$host/comments/post/$postId'));
    if (response.statusCode != 200)
      throw Exception('Failed to load comments: ${response.statusCode}');
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return (data['comments'] as List? ?? [])
        .map((item) => Comment.fromJson(item))
        .toList();
  }
}
