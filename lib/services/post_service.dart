import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models.dart';
import '../models/post.dart';

class PostService {
  static const host = 'https://dummyjson.com';
  Future<List<PostModel>> getPostModels({int limit = 30, int skip = 0}) async {
    final response =
        await http.get(Uri.parse('$host/posts?limit=$limit&skip=$skip'));
    if (response.statusCode != 200) throw Exception('Unable to load posts');
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return (data['posts'] as List)
        .map((item) => PostModel.fromJson(item))
        .toList();
  }

  Future<List<Post>> getPosts({int limit = 30, int skip = 0}) async {
    final uri = Uri.parse('$host/posts?limit=$limit&skip=$skip');
    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});
    if (response.statusCode != 200)
      throw Exception('Failed to load posts: ${response.statusCode}');
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return (data['posts'] as List? ?? [])
        .map((item) => Post.fromJson(item))
        .toList();
  }

  Future<List<PostModel>> getPostsByUser(int userId) async {
    final response = await http.get(Uri.parse('$host/users/$userId/posts'));
    if (response.statusCode != 200)
      throw Exception('Unable to load profile posts');
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return (data['posts'] as List)
        .map((item) => PostModel.fromJson(item))
        .toList();
  }

  Future<List<CommentModel>> getComments(int postId) async {
    final response = await http.get(Uri.parse('$host/comments/post/$postId'));
    if (response.statusCode != 200) throw Exception('Unable to load comments');
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return (data['comments'] as List)
        .map((item) => CommentModel.fromJson(item))
        .toList();
  }
}
