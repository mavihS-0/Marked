import 'package:flutter/material.dart';
import 'attendance_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        hoverColor: Color(0xFF6f4dea),
      ),
      initialRoute: '/HomePage',
      debugShowCheckedModeBanner: false,
      routes: {
        '/HomePage': (context) => const HomePage(),
        '/Attendance': (context) => const AttendancePage(),
      },
    );
  }
}
