// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:school_web/web/base/base_mock_data.dart';

import 'classes.dart';
import 'majors_models.dart';
import 'teacher.dart';

class Timetable {
  String? id;
  String? classId;
  String? teacherId;
  String? majorId;
  ClassInfoData? classes;
  TeacherData? teacher;
  MajorsData? majorsData;
  int? duration;
  String? status;
  DateTime? startTime;
  DateTime? endTime;
  String? createdAt;
  String? updatedAt;
  Timetable({
    this.id,
    this.classId,
    this.teacherId,
    this.majorId,
    this.classes,
    this.teacher,
    this.majorsData,
    this.duration,
    this.status,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'classId': classId,
      'teacherId': teacherId,
      'majorId': majorId,
      'classes': classes?.toJson(),
      'teacher': teacher?.toJson(),
      'majorsData': majorsData?.toJson(),
      'duration': duration,
      'status': status,
      'startTime': startTime,
      'endTime': endTime,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Timetable.fromMap(Map<String, dynamic> map) {
    return Timetable(
      classId: map['classId'] != null ? map['classId'] as String : null,
      teacherId: map['teacherId'] != null ? map['teacherId'] as String : null,
      majorId: map['majorId'] != null ? map['majorId'] as String : null,
      classes: map['classes'] != null ? ClassInfoData.fromJson(map['classes'] as Map<String, dynamic>) : null,
      teacher: map['teacher'] != null ? TeacherData.fromJson(map['teacher'] as Map<String, dynamic>) : null,
      majorsData: map['majorsData'] != null ? MajorsData.fromJson(map['majorsData'] as Map<String, dynamic>) : null,
      duration: map['duration'] != null ? map['duration'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      // startTime: map['startTime'] != null ? map['startTime'] as String : null,
      // endTime: map['endTime'] != null ? map['endTime'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Timetable.fromJson(String source) => Timetable.fromMap(json.decode(source) as Map<String, dynamic>);

  Timetable copyWith({
    String? classId,
    String? teacherId,
    String? majorId,
    ClassInfoData? classes,
    TeacherData? teacher,
    MajorsData? majorsData,
    int? duration,
    String? status,
    DateTime? startTime,
    DateTime? endTime,
    String? createdAt,
    String? updatedAt,
  }) {
    return Timetable(
      classId: classId ?? this.classId,
      teacherId: teacherId ?? this.teacherId,
      majorId: majorId ?? this.majorId,
      classes: classes ?? this.classes,
      teacher: teacher ?? this.teacher,
      majorsData: majorsData ?? this.majorsData,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class TimetableMockData extends BaseMockData {
  // List<Timetable> generateTimetableInWeek(
  //   DateTime startTime,
  //   Classes classes,
  //   TeacherData teacherData,
  //   MajorsData majorsData,
  // ) {
  //   final timetables = <Timetable>[];
  //   print(classes.id);
  //   print(teacherData.sId);
  //   print(majorsData.sId);
  //   for (var i = 0; i < 7; i++) {
  //     final currentTime = DateTime(startTime.year, startTime.month, startTime.day + i);
  //     var currentHour = 6;
  //     while (currentHour <= 22) {
  //       final time = DateTime(currentTime.year, currentTime.month, currentTime.day + i, currentHour);
  //       timetables.add(Timetable(
  //         id: '${startTime.day}_$currentHour',
  //         classId: classes.id,
  //         teacherId: teacherData.sId,
  //         majorId: majorsData.sId,
  //         classes: ClassInfoData(className: classes.className),
  //         teacher: TeacherData(fullName: generateName()),
  //         majorsData: MajorsData(name: generateMajor()),
  //         duration: const Duration(hours: 2).inSeconds,
  //         status: generateType(),
  //         startTime: time.toLocal(),
  //         endTime: time.add(const Duration(hours: 2)).toLocal(),
  //       ));

  //       currentHour += 2;
  //     }
  //   }
  //   return timetables;
  // }
}
