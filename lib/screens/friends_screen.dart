import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});
  final people = const [
    'Cyrus Robles',
    'Diana Prince',
    'Bruce Wayne',
    'Tony Stark',
    'Natasha Romanoff'
  ];
  @override
  Widget build(BuildContext context) =>
      ListView(padding: const EdgeInsets.all(12), children: [
        const Padding(
            padding: EdgeInsets.all(8),
            child: Text('People you may know',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ...people.map((p) => Card(
            child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(p),
                subtitle: const Text('CCITBook member'),
                trailing: OutlinedButton(
                    onPressed: () {}, child: const Text('Add')))))
      ]);
}
