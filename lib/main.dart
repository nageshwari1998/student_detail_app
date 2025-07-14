import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/course_screen.dart';
import 'screens/student_list_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const StudentDetailApp());
}

class StudentDetailApp extends StatelessWidget {
  const StudentDetailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Detail App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/courses': (context) => const CourseScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/students') {
          final course = settings.arguments as String? ?? '';
          return MaterialPageRoute(
            builder: (_) => StudentListScreen(course: course),
          );
        }
        return null;
      },
    );
  }
}
