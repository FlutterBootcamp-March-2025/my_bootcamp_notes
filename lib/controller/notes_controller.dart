import 'package:get/get.dart';

import '../model/note.dart';

class NotesController extends GetxController {
  List<Note> notes = [Note()].obs;

  @override
  void onInit() {
    super.onInit();
    notes.removeLast();
  }

  loadNotes(docs) {
    for (var doc in docs) {
      notes.add(Note(id: doc.id, title: doc['title'], note: doc['note']));
    }
  }
}
