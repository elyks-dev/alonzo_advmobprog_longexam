import 'package:alonzo_advmobprog_longexam1/constants.dart';
import 'package:alonzo_advmobprog_longexam1/services/auth_service.dart';
import 'package:alonzo_advmobprog_longexam1/screens/home_screen.dart';
import 'package:alonzo_advmobprog_longexam1/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    final logged = await AuthService().isLoggedIn();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) =>
                logged ? const HomeScreen() : const SignInScreen()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: APP_PRIMARY,
      body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset('lib/assets/images/NUCCITLogo_White.png',
            width: 120,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.people_alt, size: 80, color: Colors.white)),
        const SizedBox(height: 18),
        const Text(APP_NAME,
            style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const CircularProgressIndicator(color: Colors.white)
      ])));
}
