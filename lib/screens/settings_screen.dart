  import 'package:alonzo_advmobprog_longexam1/constants.dart';
import 'package:alonzo_advmobprog_longexam1/screens/signin_screen.dart';
import 'package:alonzo_advmobprog_longexam1/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:alonzo_advmobprog_longexam1/providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool dark = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      if (!mounted) return;
      setState(() {
        notifications = prefs.getBool('notifications_enabled') ?? true;
        dark = prefs.getBool('dark_mode') ?? false;
      });
    });
  }

  Future<void> _save(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Settings'), backgroundColor: APP_PRIMARY),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const Text('Preferences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SwitchListTile(
            title: const Text('Push notifications'),
            value: notifications,
            onChanged: (value) {
              setState(() => notifications = value);
              _save('notifications_enabled', value);
            }),
        SwitchListTile(
            title: const Text('Dark appearance'),
            value: context.watch<ThemeProvider>().isDark,
            onChanged: (value) {
              setState(() => dark = value);
              context.read<ThemeProvider>().setDark(value);
            }),
        const Divider(height: 32),
        ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sign out', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await UserService().signOut();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                  (_) => false);
            }),
      ]),
    );
  }
}
