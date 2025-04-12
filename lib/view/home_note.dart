import 'package:flutter/material.dart';

import '../model/note.dart';

class HomeNote extends StatelessWidget {
  final Note note;
  const HomeNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(children: [Text(note.title), Text(note.note)]));
  }
}
