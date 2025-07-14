import 'package:flutter/material.dart';
import 'add_student_screen.dart';
import 'edit_student_screen.dart';
import 'package:http/http.dart' as http;
import '../api_base.dart';
import 'dart:convert';

class StudentListScreen extends StatefulWidget {
  final String course;
  const StudentListScreen({super.key, required this.course});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Map<String, dynamic>> allStudents = [];
  bool isLoading = false;
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    setState(() {
      isLoading = true;
      errorMsg = null;
    });
    try {
      final response = await http.get(
        Uri.parse(
          '${getBaseUrl()}?course=${Uri.encodeComponent(widget.course)}',
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          allStudents = data.cast<Map<String, dynamic>>();
        });
      } else {
        setState(() {
          errorMsg = 'Failed to fetch students: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        errorMsg = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.course} Students')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMsg != null
          ? Center(child: Text(errorMsg!))
          : ListView.builder(
              itemCount: allStudents.length,
              itemBuilder: (context, index) {
                final student = allStudents[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.deepPurple.shade100,
                          radius: 18,
                          child: Text(
                            student['name'] != null
                                ? student['name'].toString()[0]
                                : '?',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student['name']?.toString() ?? '',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Age: ${student['age']?.toString() ?? ''}',
                                style: const TextStyle(fontSize: 13),
                              ),
                              Text(
                                'Course: ${student['course']?.toString() ?? ''}',
                                style: const TextStyle(fontSize: 13),
                              ),
                              Text(
                                'Email: ${student['email']?.toString() ?? ''}',
                                style: const TextStyle(fontSize: 13),
                              ),
                              Text(
                                'Year: ${student['year']?.toString() ?? ''}',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: 18,
                              ),
                              constraints: const BoxConstraints.tightFor(
                                width: 36,
                                height: 36,
                              ),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditStudentScreen(
                                      id:
                                          (student['_id'] ??
                                                  student['id'] ??
                                                  '')
                                              .toString(),
                                      currentName:
                                          student['name']?.toString() ?? '',
                                      currentAge:
                                          int.tryParse(
                                            student['age']?.toString() ?? '',
                                          ) ??
                                          0,
                                      currentCourse:
                                          student['course']?.toString() ?? '',
                                      currentEmail:
                                          student['email']?.toString() ?? '',
                                      currentYear:
                                          student['year']?.toString() ?? '',
                                    ),
                                  ),
                                );
                                if (result == true) {
                                  await fetchStudents();
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 18,
                              ),
                              constraints: const BoxConstraints.tightFor(
                                width: 36,
                                height: 36,
                              ),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Student'),
                                    content: const Text(
                                      'Are you sure you want to delete this student?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirm == true) {
                                  try {
                                    final id = student['_id'] ?? student['id'];
                                    final response = await http.delete(
                                      Uri.parse('${getBaseUrl()}/$id'),
                                    );
                                    if (response.statusCode == 200) {
                                      await fetchStudents();
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Student deleted'),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Failed to delete: ${response.body}',
                                          ),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error: $e')),
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddStudentScreen(courseName: widget.course),
            ),
          );
          if (result == true) {
            await fetchStudents();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
