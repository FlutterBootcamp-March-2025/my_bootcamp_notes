import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/note.dart';

class NotesController extends GetxController {
  List<Note> notes = [Note()].obs;

  @override
  void onInit() {
    super.onInit();
    notes.removeLast();
  }

  sort() {
    notes.sort((a, b) => a.title.compareTo(b.title));
  }

  loadNotes(docs) {
    for (var doc in docs) {
      notes.add(Note(id: doc.id, title: doc['title'], note: doc['note']));
    }
  }

  addNote(Note note) {
    final newNote = <String, dynamic>{'title': note.title, 'note': note.note};

    var db = FirebaseFirestore.instance;
    db.collection('Notes').add(newNote).then((DocumentReference doc) {
      note.id = doc.id;
      notes.add(note);
    });
  }

  updateNote(Note note) {
    var index = notes.indexWhere((element) => element.id == note.id);
    if (index != -1) {
      var db = FirebaseFirestore.instance;
      db.collection('Notes').doc(note.id).update(<String, dynamic>{
        'title': note.title,
        'note': note.note,
      });

      notes[index] = note;
    } else {
      addNote(note);
    }

    sort();
  }

  deleteNote(Note note) {
    var db = FirebaseFirestore.instance;
    db.collection('Notes').doc(note.id).delete().then((doc) {
      notes.remove(note);
    });
  }
}
