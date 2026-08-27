import 'package:flutter/material.dart';

class CustomInkWellButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const CustomInkWellButton(
      {super.key, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(padding: const EdgeInsets.all(10), child: Text(label)));
}
