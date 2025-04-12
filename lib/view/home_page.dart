import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_bootcamp_notes/controller/notes_controller.dart';

import 'home_note.dart';

class HomePage extends StatelessWidget {
  final NotesController controller;

  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final notes = controller.notes;

    return Obx(
      () => ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return HomeNote(note: notes[index]);
        },
      ),
    );
  }
}
