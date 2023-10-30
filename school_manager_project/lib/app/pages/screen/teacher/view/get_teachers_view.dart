// ignore_for_file: unnecessary_type_check

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_manager_project/app/models/teacher.dart';
import 'package:school_manager_project/app/pages/screen/teacher/detail/teacher_detail_screen.dart';

class GetTeachersView extends StatelessWidget {
  const GetTeachersView({super.key});

  Future<List<TeacherData>> _getWorkingTeachers() async {
    final response =
        await http.get(Uri.parse('https://backend-shool-project.onrender.com/admin/working-teachers'));
    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> data = responseData['data'];

      if (data is List) {
        List<TeacherData> teachers = data.map((teacherData) => TeacherData.fromJson(teacherData)).toList();
        teachers.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));

        return teachers = teachers.reversed.toList();
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load working teachers');
    }
  }

  Future<List<TeacherData>> _getRetiredTeachers() async {
    final response =
        await http.get(Uri.parse('https://backend-shool-project.onrender.com/admin/retired-teachers'));
    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> data = responseData['data'];
      if (data is List) {
        List<TeacherData> teachers = data.map((teacherData) => TeacherData.fromJson(teacherData)).toList();
        teachers.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));

        return teachers = teachers.reversed.toList();
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load retired teachers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Danh sách giáo viên',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          bottom: const TabBar(
            labelColor: Color(0xFF7E8695),
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            indicatorWeight: 1,
            indicatorColor: Colors.pink,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'Đang làm việc'),
              Tab(text: 'Đã nghỉ'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TabBarView(
            children: [
              FutureBuilder<List<TeacherData>>(
                future: _getWorkingTeachers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Không có giáo viên đang làm việc.'));
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Giáo viên đang làm việc: ${snapshot.data?.length}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.green),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final teacher = snapshot.data![index];
                              return _buildTeacherCard(teacher, context);
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              FutureBuilder<List<TeacherData>>(
                future: _getRetiredTeachers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No retired teachers available.'));
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Giáo viên đã nghỉ: ${snapshot.data!.length}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.red),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final teacher = snapshot.data![index];
                              return _buildTeacherCard(teacher, context);
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

  Widget _buildTeacherCard(TeacherData teacher, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(teacher.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png'),
          radius: 30,
        ),
        title: Text(
          teacher.fullName ?? '',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(teacher.teacherCode ?? ''),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeacherDetailScreen(teacher: teacher),
            ),
          );
        },
      ),
    );
  }
}
