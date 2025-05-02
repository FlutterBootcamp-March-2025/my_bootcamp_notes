import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_bootcamp_notes/controller/notes_controller.dart';
import 'package:my_bootcamp_notes/model/note.dart';

class NoteEdit extends StatelessWidget {
  final Note note;

  const NoteEdit({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: note.title);
    final noteController = TextEditingController(text: note.note);
    final controller = Get.find<NotesController>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Note'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title here',
                    labelText: 'Title',
                  ),
                  maxLength: 255,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: noteController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Notes here',
                    labelText: 'Notes',
                  ),
                  maxLines: 5,
                  maxLength: 255,
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        note.title = titleController.text;
                        note.note = noteController.text;
                        await controller.updateNote(note);
                        Get.offAllNamed('/');
                      },
                      icon: Icon(Icons.save),
                      label: Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
