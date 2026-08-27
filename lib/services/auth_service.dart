import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const _loggedIn = 'logged_in';
  static const _name = 'user_name';
  static const _email = 'user_email';
  static const _userId = 'user_id';
  static const _token = 'access_token';

  Future<bool> isLoggedIn() async =>
      (await SharedPreferences.getInstance()).getBool(_loggedIn) ?? false;

  Future<void> signIn(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedIn, true);
    await prefs.setString(_name, name);
    await prefs.setString(_email, email);
  }

  Future<void> login(String username, String password) async {
    final response = await http.post(
        Uri.parse('https://dummyjson.com/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'username': username, 'password': password, 'expiresInMins': 60}));
    if (response.statusCode != 200)
      throw Exception('Invalid username or password');
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedIn, true);
    await prefs.setInt(_userId, data['id'] as int);
    await prefs.setString(
        _name, '${data['firstName'] ?? ''} ${data['lastName'] ?? ''}'.trim());
    await prefs.setString(_email, data['email'] ?? '');
    await prefs.setString(_token, data['accessToken'] ?? '');
  }

  Future<int?> get userId async =>
      (await SharedPreferences.getInstance()).getInt(_userId);

  Future<void> signOut() async =>
      (await SharedPreferences.getInstance()).setBool(_loggedIn, false);
  Future<String> get name async =>
      (await SharedPreferences.getInstance()).getString(_name) ?? 'Kyle Alonzo';
  Future<String> get email async =>
      (await SharedPreferences.getInstance()).getString(_email) ??
      'student@example.com';
}
