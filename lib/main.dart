import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_bootcamp_notes/controller/auth_controller.dart';
import 'package:my_bootcamp_notes/controller/notes_controller.dart';
import 'package:my_bootcamp_notes/firebase_options.dart';
import 'package:my_bootcamp_notes/view/about_page.dart';
import 'package:my_bootcamp_notes/view/auth/login_page.dart';
import 'package:my_bootcamp_notes/view/home_page.dart';
import 'package:my_bootcamp_notes/view/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  init();
  runApp(const MyApp());
}

void init() {
  Get.put(NotesController());
  Get.put(AuthController());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notes App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => AuthWrapper()),
        GetPage(name: '/main', page: () => MainPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
      home: AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Obx(() {
      if (authController.isLoading.value) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      return authController.user.value != null ? MainPage() : LoginPage();
    });
  }
}
