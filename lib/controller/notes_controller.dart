import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/note.dart';

class NotesController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<Note> notes = <Note>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (notes.isNotEmpty) {
      notes.removeLast();
    }
  }

  sort() {
    // Sort notes by creation time (newest first)
    notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  loadNotes(docs) {
    for (var doc in docs) {
      DateTime createdAt = doc['createdAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(doc['createdAt']) 
          : DateTime.now();
      notes.add(Note(
        id: doc.id, 
        title: doc['title'], 
        note: doc['note'],
        createdAt: createdAt,
      ));
    }
    // Sort notes by creation time (newest first)
    notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> addNote(Note note) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final newNote = <String, dynamic>{
          'title': note.title,
          'note': note.note,
          'createdAt': note.createdAt.millisecondsSinceEpoch,
        };

        await _firestore
            .collection('Notes')
            .doc(user.uid)
            .collection('user_notes')
            .add(newNote)
            .then((DocumentReference doc) {
              note.id = doc.id;
              notes.add(note);
              // Sort notes by creation time (newest first)
              sort();
            });
      } catch (e) {
        Get.snackbar('Error', 'Failed to add note: $e');
      }
    }
  }

  Future<void> updateNote(Note note) async {
    var index = notes.indexWhere((element) => element.id == note.id);
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        if (index != -1) {
          await _firestore
              .collection('Notes')
              .doc(user.uid)
              .collection('user_notes')
              .doc(note.id)
              .update(<String, dynamic>{
                'title': note.title,
                'note': note.note,
                'createdAt': note.createdAt.millisecondsSinceEpoch,
              });
          // Update the properties of the existing note object instead of replacing it
          notes[index].title = note.title;
          notes[index].note = note.note;
          // Trigger a refresh of the list
          notes.refresh();
        } else {
          await addNote(note);
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to update note: $e');
      }
    }
  }

  Future<void> deleteNote(Note note) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await _firestore
            .collection('Notes')
            .doc(user.uid)
            .collection('user_notes')
            .doc(note.id)
            .delete();
        notes.remove(note);
      } catch (e) {
        Get.snackbar('Error', 'Failed to delete note: $e');
      }
    }
  }
}
