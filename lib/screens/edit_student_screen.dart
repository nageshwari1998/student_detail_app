import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_base.dart';
import 'dart:convert';

class EditStudentScreen extends StatefulWidget {
  final String id;
  final String currentName;
  final int currentAge;
  final String currentCourse;
  final String currentEmail;
  final String currentYear;

  const EditStudentScreen({
    super.key,
    required this.id,
    required this.currentName,
    required this.currentAge,
    required this.currentCourse,
    required this.currentEmail,
    required this.currentYear,
  });

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController courseController;
  late TextEditingController emailController;
  late TextEditingController yearController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    ageController = TextEditingController(text: widget.currentAge.toString());
    courseController = TextEditingController(text: widget.currentCourse);
    emailController = TextEditingController(text: widget.currentEmail);
    yearController = TextEditingController(text: widget.currentYear);
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    courseController.dispose();
    emailController.dispose();
    yearController.dispose();
    super.dispose();
  }

  Future<void> updateStudent() async {
    final name = nameController.text;
    final age = int.tryParse(ageController.text) ?? 0;
    final course = courseController.text;
    final email = emailController.text;
    final year = yearController.text;

    final url = Uri.parse('${getBaseUrl()}/${widget.id}');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'age': age,
          'course': course,
          'email': email,
          'year': year,
        }),
      );

      if (response.statusCode == 200) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Student updated successfully')),
        );
        Navigator.pop(context, true); // return to refresh
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update student: \n${response.body}'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Student')),
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
              controller: courseController,
              decoration: const InputDecoration(labelText: 'Course'),
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
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: updateStudent,
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
