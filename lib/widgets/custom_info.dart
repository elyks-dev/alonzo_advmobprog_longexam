import 'package:flutter/material.dart';

class CustomInfo extends StatelessWidget {
  final String title;
  final String value;
  const CustomInfo({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) =>
      ListTile(title: Text(title), subtitle: Text(value));
}
