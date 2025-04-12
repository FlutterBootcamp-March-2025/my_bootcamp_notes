import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_bootcamp_notes/controller/notes_controller.dart';

import '../model/note.dart';
import 'notes/note_edit.dart';

class HomeNote extends StatelessWidget {
  final NotesController controller;
  final Note note;
  const HomeNote({super.key, required this.controller, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: SizedBox(
        height: 200,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      note.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Expanded(child: Container()),
                    PopupMenuButton(
                      itemBuilder: ((context) {
                        return [
                          PopupMenuItem(
                            child: TextButton(
                              onPressed: () {
                                Get.back();
                                Get.to(
                                  () => NoteEdit(
                                    controller: controller,
                                    note: note,
                                  ),
                                );
                              },
                              child: const Text('Edit'),
                            ),
                          ),
                          PopupMenuItem(
                            child: TextButton(
                              onPressed: () {
                                Get.back();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Delete the note ${note.title}?',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.headlineLarge,
                                      ),
                                      content: Text(
                                        'Are you sure?',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                      ),
                                      actions: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            controller.deleteNote(note);
                                            Get.back();
                                          },
                                          icon: const Icon(Icons.check),
                                          label: const Text('Yes'),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: const Icon(Icons.delete),
                                          label: const Text('No'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text('Delete'),
                            ),
                          ),
                        ];
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(note.note, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
