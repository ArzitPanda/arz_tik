import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tik_tok/constants.dart';
import 'package:tik_tok/controller/auth_controller.dart';
import 'package:tik_tok/views/screens/home_screen.dart';
import 'package:tik_tok/views/screens/auth/login_screen.dart';
import 'package:tik_tok/views/screens/auth/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: 'https://fzilzqmtskjhazidasxu.supabase.co', anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ6aWx6cW10c2tqaGF6aWRhc3h1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjcxNDIxMDYsImV4cCI6MTk4MjcxODEwNn0.56zv4cXbTpGaqBgdL8cW0DWEz4uJweqJN3wsGFFNURI');
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());

  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tiktok',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,

      ),
      home: const HomeScreen()
    );
  }
}

