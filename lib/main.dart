import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:my_bootcamp_notes/controller/notes_controller.dart';
import 'package:my_bootcamp_notes/firebase_options.dart';
import 'package:my_bootcamp_notes/view/about_page.dart';
import 'package:my_bootcamp_notes/view/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final NotesController controller = Get.put(NotesController());
  int currentIndex = 0;
  bool hasNotesLoaded = false;

  loadNotes() async {
    if (hasNotesLoaded) return;

    final db = FirebaseFirestore.instance;
    final notes = db.collection('Notes');
    final snapshot = await notes.get();
    controller.loadNotes(snapshot.docs);
    hasNotesLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    final pages = [HomePage(controller: controller), AboutPage()];
    return GetMaterialApp(
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(
                  'Something went wrong!',
                  style: TextStyle(fontSize: 32.0),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            loadNotes();

            return Scaffold(
              appBar: AppBar(
                title: Text('My Notes'),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              body: pages[currentIndex],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
