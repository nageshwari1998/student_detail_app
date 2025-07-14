import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real student data
    final student = {
      'name': 'Student Name',
      'email': 'student@email.com',
      'course': 'CSE',
      'year': '2022-2026',
      'joined': '2022-07-01',
    };
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(student['name'] != null ? student['name']![0] : '?', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            Text(student['name'] ?? '', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(student['email'] ?? '', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Course: ${student['course'] ?? ''}', style: const TextStyle(fontSize: 16)),
            Text('Year: ${student['year'] ?? ''}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Joined on: ${student['joined'] ?? ''}', style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
