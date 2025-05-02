import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_bootcamp_notes/controller/notes_controller.dart';

import 'home_note.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotesController>();
    final notes = controller.notes;

    return Obx(
      () => ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return HomeNote(controller: controller, note: notes[index]);
        },
      ),
    );
  }
}
