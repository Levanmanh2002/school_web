// ignore_for_file: unnecessary_type_check

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_manager_project/app/models/classes.dart';
import 'package:http/http.dart' as http;
import 'package:school_manager_project/app/pages/screen/classes/detail/class_info_detail.dart';

class ClassesInfoView extends StatefulWidget {
  const ClassesInfoView({super.key});

  @override
  State<ClassesInfoView> createState() => _ClassesInfoViewState();
}

class _ClassesInfoViewState extends State<ClassesInfoView> {
  Future<List<ClassInfoData>> _getClassInfo() async {
    var response = await http.get(Uri.parse('https://backend-shool-project.onrender.com/admin/class-info'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['classInfo'];

      List<ClassInfoData> classes = data.map((e) => ClassInfoData.fromJson(e)).toList();

      return classes;
    } else {
      throw Exception('Failed to load classes info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Danh sách lớp học',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<ClassInfoData>>(
        future: _getClassInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có lớp học.'));
          } else {
            return Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Danh sách lớp học: ${snapshot.data?.length}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.green),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final classes = snapshot.data![index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              elevation: 1,
                              color: Colors.white,
                              child: Container(
                                width: double.maxFinite,
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ClassesInfoDetail(
                                          students: classes.students,
                                          classes: classes.className.toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Lớp: ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: classes.className.toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Tổng số học sinh lớp ${classes.className.toString()} là: ',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromARGB(255, 240, 206, 206),
                                                ),
                                              ),
                                              TextSpan(
                                                text: classes.numberOfStudents.toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Column(
                            //   children: classes.students!.map((student) {
                            //     return _buildTeacherCard(student, context);
                            //   }).toList(),
                            // )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
