import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  final List<String> courses = const [
    'EEE', 'ECE', 'CSE', 'MECH', 'AI & DATA SCIENCE'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              title: Text(course, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () => Navigator.pushNamed(context, '/students', arguments: course),
            ),
          );
        },
      ),
    );
  }
}
