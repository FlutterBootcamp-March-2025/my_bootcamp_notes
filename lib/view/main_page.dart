import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_bootcamp_notes/controller/auth_controller.dart';

import '../controller/notes_controller.dart';
import '../model/note.dart';
import 'about_page.dart';
import 'home_page.dart';
import 'notes/note_edit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  NotesController? controller;
  int currentIndex = 0;
  bool hasNotesLoaded = false;

  loadNotes() async {
    if (hasNotesLoaded) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final db = FirebaseFirestore.instance;
        final userNotes = db
            .collection('Notes')
            .doc(user.uid)
            .collection('user_notes');
        final snapshot = await userNotes.get();
        Get.find<NotesController>().loadNotes(snapshot.docs);
        hasNotesLoaded = true;
      } catch (e) {
        Get.snackbar('Error', 'Failed to load notes: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final pages = [HomePage(), AboutPage()];

    // Load notes when the widget is built
    loadNotes();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: IconButton.filled(
              onPressed: () {
                authController.logout();
              },
              icon: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: pages[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => NoteEdit(note: Note(title: '', note: '')));
        },
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected:
            (value) => setState(() {
              currentIndex = value;
            }),
        destinations: [
          NavigationDestination(icon: Icon(Icons.house), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'About'),
        ],
      ),
    );
  }
}
