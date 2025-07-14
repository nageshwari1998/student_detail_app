class Student {
  final String id;
  final String name;
  final String email;
  final int age;
  final String course;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.course,
  });

  // Factory method to create a Student from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      age: json['age'],
      course: json['course'],
    );
  }

  // Convert Student object to JSON (useful for POST)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'course': course,
    };
  }
}
