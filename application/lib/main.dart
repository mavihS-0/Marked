import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/attendance_page.dart';
import 'presentation/screens/home_page.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        hoverColor: Color(0xFF6f4dea),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
