import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:school_manager_project/app/models/classes.dart';
import 'package:school_manager_project/app/models/majors_models.dart';
import 'package:school_manager_project/app/models/teacher.dart';
import 'package:school_manager_project/app/models/timetable.dart';
import 'package:school_manager_project/app/routes/pages.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  List<Timetable> timeTables = [];
  Map<String, Map<String, List<Timetable>>> timetablesMap = {};
  String morning = 'MORNING';
  String lunch = 'LUNCH';
  String dinner = 'DINNER';

  late final dayModeType = <String, String>{morning: 'Sáng', lunch: 'Chiều', dinner: 'Tối'};

  final startMorning = 6;
  final endMoring = 12;
  final startLunch = 12;
  final endLunch = 18;
  final startAfternoon = 18;
  final endAfternoon = 22;

  @override
  void initState() {
    super.initState();
    initializeTimetable();
  }

  DateTime _getStartOfWeek() {
    var startOfWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    startOfWeek = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day, 0, 0, 0);
    return startOfWeek;
  }

  Future<List<Timetable>> fetchDataFromAPI(DateTime startTime) async {
    final response = await http.get(
      Uri.parse('https://backend-shool-project.onrender.com/timetable/get-all'),
    );

    final timetables = <Timetable>[];

    if (response.statusCode == 201) {
      final data = json.decode(response.body);  

      if (data['status'] == "SUCCESS") {
        final timetableList = data['data'];
        print(timetableList);

        for (var timetableData in timetableList) {
          final timetable = Timetable(
            id: timetableData['_id'],
            duration: timetableData['duration'] ?? 0,
            startTime: DateTime.parse(timetableData['startTime']).toLocal(),
            endTime: DateTime.parse(timetableData['endTime']).add(const Duration(hours: 2)).toLocal(),
            createdAt: DateTime.parse(timetableData['createdAt']).toIso8601String(),
            updatedAt: DateTime.parse(timetableData['updatedAt']).toIso8601String(),
            classId: timetableData['classId'],
            classes: ClassInfoData(className: timetableData['class']),
            teacherId: timetableData['teacherId'],
            teacher: TeacherData(),
            majorId: timetableData['majorId'],
            majorsData: MajorsData(),
            status: timetableData['status'],
          );

          timetables.add(timetable);
          print(timetable);
          print('Timetable: $timetable');
        }
      } else {
        print('API response error: ${data['message']}');
      }
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }

    return timetables;
  }

  initializeTimetable() async {
    // timeTables.addAll(TimetableMockData().generateTimetableInWeek(_getStartOfWeek(), classes, teacherData, majorsData));
    final fetchedTimetables = await fetchDataFromAPI(_getStartOfWeek());
    timeTables.addAll(fetchedTimetables);

    timeTables.sort((a, b) => a.startTime!.compareTo(b.startTime!));
    for (final timetable in timeTables) {
      final key = DateFormat('dd/MM/yyyy').format(timetable.startTime!);
      final type = getTimeTableType(timetable.startTime!, timetable.endTime!);
      if (timetablesMap.containsKey(key)) {
        if (timetablesMap[key]!.containsKey(type)) {
          timetablesMap[key]![type]!.add(timetable);
        } else {
          timetablesMap[key]![type] = [];
          timetablesMap[key]![type]!.add(timetable);
        }
      } else {
        timetablesMap[key] = {};
        if (timetablesMap[key]!.containsKey(type)) {
          timetablesMap[key]![type]!.add(timetable);
        } else {
          timetablesMap[key]![type] = [];
          timetablesMap[key]![type]!.add(timetable);
        }
      }
    }
    setState(() {});
  }

  void deleteTimeTable(Timetable timetable) {
    final key = DateFormat('dd/MM/yyyy').format(timetable.startTime!);
    final type = getTimeTableType(timetable.startTime!, timetable.endTime!);
    final list = timetablesMap[key]![type] ?? [];
    final index = list.indexWhere((element) => element.id == timetable.id);
    if (index != -1) {
      list.removeAt(index);
    }
    setState(() {});
  }

  String getTimeTableType(DateTime startTime, DateTime endTime) {
    var startHour = startTime.hour;
    startHour = startHour == 0 ? 24 : startHour;
    var endHour = endTime.hour;
    endHour = endHour == 0 ? 24 : endHour;
    if (startHour >= startMorning && endHour <= endMoring) {
      return morning;
    } else if (startHour > startLunch) {
      if (endHour <= endLunch) {
        return lunch;
      } else {
        return dinner;
      }
    } else {
      return dinner;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Row(
          children: [
            IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back, color: Colors.black)),
            const Text(
              'Tạo lịch học dành cho sinh viên',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ],
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
                    ...buildDayMode()
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

  List<Widget> buildDayMode() {
    return dayModeType.keys
        .map(
          (key) => IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFbdccd6)),
                  ),
                  child: Text(dayModeType[key] ?? ''),
                ),
                ...buildListTimeableInDayModeKey(key)
              ],
            ),
          ),
        )
        .toList();
  }

  List<Widget> buildListTimeableInDayModeKey(String key) {
    final widgets = <Widget>[];
    for (final dayKey in timetablesMap.keys) {
      final data = timetablesMap[dayKey]![key] ?? [];
      print(dayKey);
      print(key);
      print(data.length);
      if (data.isEmpty) {
        widgets.add(Container(
          width: 300,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFbdccd6)),
          ),
        ));
      } else {
        widgets.add(buildTimetable(data));
      }
    }
    return widgets;
  }

  Widget buildTimetable(List<Timetable> timetables) {
    return Column(
        children: timetables.map(
      (e) {
        final startTime = DateFormat.Hm().format(e.startTime!);
        final endTime = DateFormat.Hm().format(e.endTime!);
        return GestureDetector(
          onDoubleTap: () {
            print(e.id);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "Xác nhận",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  content: const Text(
                    "Bạn có chắc chắn muốn xóa thời khóa biểu này?",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        "Hủy",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      child: const Text(
                        "Đồng ý",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.red),
                      ),
                      onPressed: () {
                        deleteTimeTable(e);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: 300,
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFbdccd6)),
            ),
            child: Column(
              children: [
                Text('Giáo viên: ${e.teacher?.fullName ?? ''}'),
                Text('Lớp học: ${e.classes?.className ?? ''}'),
                Text('Môn học: ${e.majorsData?.name ?? ''}'),
                Text('Thời gian: $startTime - $endTime'),
              ],
            ),
          ),
        );
      },
    ).toList());
  }
}
