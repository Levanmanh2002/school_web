import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_manager_project/app/routes/pages.dart';

class TimetablePages extends StatelessWidget {
  const TimetablePages({super.key});

  @override
  Widget build(BuildContext context) {
    final List<List<String>> timetableData = [
      ['ưe', '', '', '', '', 'Tiết 1', 'Tiết 2'],
      ['ưe', 'Tiết 3', 'Tiết 4', 'Tiết 5', 'Tiết 6', 'Tiết 7', ''],
      ['ưe', 'Lập trình Web nâng cao', '', '', '', '', ''],
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Tạo lịch học dành cho sinh viên',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
                onPressed: () {
                  Get.toNamed(Routes.CREATE);
                },
                icon: const Icon(Icons.add)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        for (var day in [
                          '',
                          'Thứ hai',
                          'Thứ ba',
                          'Thứ tư',
                          'Thứ năm',
                          'Thứ sáu',
                          'Thứ bảy',
                          'Chủ Nhật'
                        ])
                          Container(
                            width: day == '' ? 100 : 300,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFbdccd6)),
                              color: const Color(0xFF042f43),
                            ),
                            child: Text(day, style: const TextStyle(color: Colors.white)),
                          ),
                      ],
                    ),
                    for (var i = 0; i < timetableData.length; i++)
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFbdccd6)),
                            ),
                            child: Text(['Sáng', 'Chiều', 'Tối'][i]),
                          ),
                          for (var item in timetableData[i])
                            Container(
                              width: 300,
                              height: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFbdccd6)),
                              ),
                              child: Column(
                                children: [
                                  Text('Giáo viên: $item'),
                                  Text('Lớp học: $item'),
                                  Text('Môn học: $item'),
                                ],
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        for (var day in [
                          '',
                          'Thứ hai',
                          'Thứ ba',
                          'Thứ tư',
                          'Thứ năm',
                          'Thứ sáu',
                          'Thứ bảy',
                          'Chủ Nhật'
                        ])
                          Container(
                            width: day == '' ? 100 : 300,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFbdccd6)),
                              color: const Color(0xFF042f43),
                            ),
                            child: Text(day, style: const TextStyle(color: Colors.white)),
                          ),
                      ],
                    ),
                    for (var i = 0; i < timetableData.length; i++)
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFbdccd6)),
                            ),
                            child: Text(['Sáng', 'Chiều', 'Tối'][i]),
                          ),
                          for (var item in timetableData[i])
                            Container(
                              width: 300,
                              height: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFbdccd6)),
                              ),
                              child: Column(
                                children: [
                                  Text('Giáo viên: $item'),
                                  Text('Lớp học: $item'),
                                  Text('Môn học: $item'),
                                ],
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
