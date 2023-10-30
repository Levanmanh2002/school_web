import 'package:school_web/web/models/student.dart';

class ClassInfoData {
  String? className;
  int? numberOfStudents;
  List<StudentData>? students;

  ClassInfoData({this.className, this.numberOfStudents, this.students});

  ClassInfoData.fromJson(Map<String, dynamic> json) {
    className = json['className'];
    numberOfStudents = json['numberOfStudents'];
    if (json['students'] != null) {
      students = <StudentData>[];
      json['students'].forEach((v) {
        students!.add(StudentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['className'] = className;
    data['numberOfStudents'] = numberOfStudents;
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
