import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  static const host = 'https://dummyjson.com';
  Future<UserModel> getUser(int id) async {
    final response = await http.get(Uri.parse('$host/users/$id'));
    if (response.statusCode != 200) throw Exception('Unable to load user');
    return UserModel.fromJson(jsonDecode(response.body));
  }
}
