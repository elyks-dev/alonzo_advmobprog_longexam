import 'package:alonzo_advmobprog_longexam1/constants.dart';
import 'package:alonzo_advmobprog_longexam1/services/user_service.dart';
import 'package:alonzo_advmobprog_longexam1/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final name = TextEditingController(text: 'emilys');
  final email = TextEditingController(text: 'emilyspass');
  bool loading = false;
  Future<void> _submit() async {
    if (name.text.trim().isEmpty || email.text.trim().isEmpty) return;
    setState(() => loading = true);
    try {
      await UserService().login(name.text.trim(), email.text.trim());
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } catch (e) {
      if (mounted) {
        setState(() => loading = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: APP_LIGHT_PRIMARY,
      body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(28),
                  child: Card(
                      elevation: 4,
                      child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Image.asset(
                                    'lib/assets/images/NUCCITLogo_Black.png',
                                    height: 64,
                                    errorBuilder: (_, __, ___) => const Icon(
                                        Icons.people_alt,
                                        size: 64,
                                        color: APP_PRIMARY)),
                                const SizedBox(height: 12),
                                const Text('Welcome to CCITBook',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: APP_DARK_PRIMARY)),
                                const SizedBox(height: 8),
                                const Text('Connect with your CCIT community.',
                                    textAlign: TextAlign.center),
                                const SizedBox(height: 24),
                                TextField(
                                    controller: name,
                                    decoration: const InputDecoration(
                                        labelText: 'Username',
                                        prefixIcon:
                                            Icon(Icons.person_outline))),
                                const SizedBox(height: 14),
                                TextField(
                                    controller: email,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon:
                                            Icon(Icons.email_outlined))),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                    onPressed: loading ? null : _submit,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: APP_PRIMARY,
                                        padding: const EdgeInsets.all(15)),
                                    child: loading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white)
                                        : const Text('Sign in'))
                              ])))))));
}
