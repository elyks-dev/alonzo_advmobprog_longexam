import 'package:alonzo_advmobprog_longexam1/constants.dart';
import 'package:alonzo_advmobprog_longexam1/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      ListView(padding: const EdgeInsets.all(16), children: [
        const Text('Menu',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _item(
            context,
            Icons.settings_outlined,
            'Settings',
            () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()))),
        _item(context, Icons.bookmark_outline, 'Saved posts', () {}),
        _item(context, Icons.help_outline, 'Help & support', () {}),
        _item(context, Icons.info_outline, 'About CCITBook', () {})
      ]);
  static Widget _item(
          BuildContext c, IconData i, String t, VoidCallback f) =>
      Card(
          child: ListTile(
              leading: Icon(i, color: APP_PRIMARY),
              title: Text(t),
              trailing: const Icon(Icons.chevron_right),
              onTap: f));
}
