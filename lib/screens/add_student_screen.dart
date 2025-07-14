import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_base.dart';
import 'dart:convert';

class AddStudentScreen extends StatelessWidget {
  final String courseName;
  const AddStudentScreen({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final emailController = TextEditingController();
    final yearController = TextEditingController();

    Future<void> submitStudent() async {
      final name = nameController.text;
      final age = int.tryParse(ageController.text) ?? 0;
      final course = courseName;
      final email = emailController.text;
      final year = yearController.text;

      final url = Uri.parse(getBaseUrl());
      try {
        final response = await http.post(
          Uri.parse(getBaseUrl()),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'name': name,
            'age': age,
            'course': course,
            'email': email,
            'year': year,
          }),
        );
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Student added successfully')),
          );
          Navigator.pop(context, true); // send flag to refresh
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add student: \n${response.body}'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Add Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(labelText: 'Year'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: courseName),
              decoration: const InputDecoration(labelText: 'Course'),
              readOnly: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: submitStudent,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
