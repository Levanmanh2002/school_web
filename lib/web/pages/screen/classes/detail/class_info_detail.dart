import 'package:flutter/material.dart';
import 'package:school_web/web/models/student.dart';
import 'package:school_web/web/pages/screen/student/detail/student_detail_screen.dart';

class ClassesInfoDetail extends StatelessWidget {
  const ClassesInfoDetail({required this.students, required this.classes, super.key});

  final List<StudentData>? students;
  final String classes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Lớp: $classes',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: ListView.builder(
          itemCount: students?.length ?? 0,
          itemBuilder: (context, index) {
            final student = students![index];

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 1,
                color: Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(student.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png'),
                    radius: 30,
                  ),
                  title: Text(
                    student.fullName ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(student.mssv ?? ''),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentDetailScreen(student: student),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
