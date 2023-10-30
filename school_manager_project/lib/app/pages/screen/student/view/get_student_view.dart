// ignore_for_file: unnecessary_type_check

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_manager_project/app/models/student.dart';
import 'package:http/http.dart' as http;
import 'package:school_manager_project/app/pages/screen/student/detail/student_detail_screen.dart';

class GetStudentView extends StatelessWidget {
  const GetStudentView({super.key});

  // Danh sách học sinh đang học
  Future<List<StudentData>> _getActiveStudent() async {
    var response = await http.get(Uri.parse('https://backend-shool-project.onrender.com/admin/students/active'));

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> data = responseData['data'];

      if (data is List) {
        List<StudentData> student = data.map((studentData) => StudentData.fromJson(studentData)).toList();
        student.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));

        return student = student.reversed.toList();
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load working student');
    }
  }

  // Danh sách học sinh đã nghỉ học
  Future<List<StudentData>> _getInactiveStudent() async {
    var response = await http.get(Uri.parse('https://backend-shool-project.onrender.com/admin/students/inactive'));

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> data = responseData['data'];

      if (data is List) {
        List<StudentData> student = data.map((studentData) => StudentData.fromJson(studentData)).toList();
        student.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));

        return student = student.reversed.toList();
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load working student');
    }
  }

  // Danh sách học sinh đang bị đình chỉ
  Future<List<StudentData>> _getSuspendedStudent() async {
    var response = await http.get(Uri.parse('https://backend-shool-project.onrender.com/admin/students/suspended'));

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> data = responseData['data'];

      if (data is List) {
        List<StudentData> student = data.map((studentData) => StudentData.fromJson(studentData)).toList();
        student.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));

        return student = student.reversed.toList();
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load working student');
    }
  }

  // Danh sách học sinh bị đuổi học
  Future<List<StudentData>> _getExpelledStudent() async {
    var response = await http.get(Uri.parse('https://backend-shool-project.onrender.com/admin/students/expelled'));

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> data = responseData['data'];

      if (data is List) {
        List<StudentData> student = data.map((studentData) => StudentData.fromJson(studentData)).toList();
        student.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));

        return student = student.reversed.toList();
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load working student');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Danh sách học sinh',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          bottom: const TabBar(
            labelColor: Color(0xFF7E8695),
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            indicatorWeight: 1,
            indicatorColor: Colors.pink,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            tabs: [
              Tab(text: 'Danh sách học sinh đang học'),
              Tab(text: 'Danh sách học sinh đã nghỉ học'),
              Tab(text: 'Danh sách học sinh đang bị đình chỉ'),
              Tab(text: 'Danh sách học sinh bị đuổi học'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TabBarView(
            children: [
              FutureBuilder<List<StudentData>>(
                future: _getActiveStudent(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Không có học sinh nào đang học.'));
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Danh sách học sinh đang học: ${snapshot.data?.length}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.green),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final student = snapshot.data![index];
                              return _buildStudentCard(student, context);
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              FutureBuilder<List<StudentData>>(
                future: _getInactiveStudent(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Không có học sinh nào nghỉ học.'));
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Danh sách học sinh đã nghỉ học: ${snapshot.data?.length}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.green),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final student = snapshot.data![index];
                              return _buildStudentCard(student, context);
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              FutureBuilder<List<StudentData>>(
                future: _getSuspendedStudent(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Không có học sinh nào bị đình chỉ.'));
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Danh sách học sinh đang bị đình chỉ: ${snapshot.data?.length}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.green),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final student = snapshot.data![index];
                              return _buildStudentCard(student, context);
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              FutureBuilder<List<StudentData>>(
                future: _getExpelledStudent(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Không có học sinh nào bị đuổi học.'));
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Danh sách học sinh bị đuổi học: ${snapshot.data?.length}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.green),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final student = snapshot.data![index];
                              return _buildStudentCard(student, context);
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentCard(StudentData studentData, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(studentData.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png'),
          radius: 30,
        ),
        title: Text(
          studentData.fullName ?? '',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(studentData.mssv ?? ''),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentDetailScreen(student: studentData),
            ),
          );
        },
      ),
    );
  }
}
