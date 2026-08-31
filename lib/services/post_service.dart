import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models.dart';
import '../models/post.dart';

class PostService {
  static const host = 'https://dummyjson.com';

  Future<String> getUserName(int userId) async {
    final response = await http.get(Uri.parse('$host/users/$userId'));

    if (response.statusCode != 200) {
      return 'Unknown User';
    }

    final data = jsonDecode(response.body);
    return '${data['firstName']} ${data['lastName']}';
  }

  Future<List<PostModel>> getPostModels({
    int limit = 30,
    int skip = 0,
  }) async {
    final response =
        await http.get(Uri.parse('$host/posts?limit=$limit&skip=$skip'));

    if (response.statusCode != 200) {
      throw Exception('Unable to load posts');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final posts = data['posts'] as List;

    List<PostModel> result = [];

    for (final item in posts) {
      final userId = item['userId'] ?? 0;
      final userName = await getUserName(userId);

      result.add(
        PostModel.fromJson(item).copyWith(userName: userName),
      );
    }

    return result;
  }

  Future<List<Post>> getPosts({
    int limit = 30,
    int skip = 0,
  }) async {
    final response =
        await http.get(Uri.parse('$host/posts?limit=$limit&skip=$skip'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load posts');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return (data['posts'] as List)
        .map((item) => Post.fromJson(item))
        .toList();
  }

  Future<List<PostModel>> getPostsByUser(int userId) async {
    final response = await http.get(Uri.parse('$host/users/$userId/posts'));

    if (response.statusCode != 200) {
      throw Exception('Unable to load profile posts');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final userName = await getUserName(userId);

    return (data['posts'] as List)
        .map((item) => PostModel.fromJson(item).copyWith(userName: userName))
        .toList();
  }

  Future<List<CommentModel>> getComments(int postId) async {
    final response = await http.get(Uri.parse('$host/comments/post/$postId'));

    if (response.statusCode != 200) {
      throw Exception('Unable to load comments');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return (data['comments'] as List)
        .map((item) => CommentModel.fromJson(item))
        .toList();
  }
}