// ignore_for_file: unnecessary_type_check, use_build_context_synchronously

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:school_manager_project/app/models/classes.dart';
import 'package:school_manager_project/app/models/majors_models.dart';
import 'package:school_manager_project/app/models/teacher.dart';

class CreateView extends StatefulWidget {
  const CreateView({super.key});

  @override
  State<CreateView> createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  Future<List<TeacherData>> _getWorkingTeachers() async {
    final response = await http.get(Uri.parse('https://backend-shool-project.onrender.com/admin/working-teachers'));
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

  Future<List<Classes>> _getClassInfo() async {
    var response = await http.get(Uri.parse('https://backend-shool-project.onrender.com/admin/classes'));

    if (response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['classes'];

      List<Classes> classes = data.map((e) => Classes.fromJson(e)).toList();

      return classes;
    } else {
      throw Exception('Failed to load classes info');
    }
  }

  Future<List<MajorsData>> _getFetchMajors() async {
    final response = await http.get(Uri.parse('https://backend-shool-project.onrender.com/admin/majors'));

    if (response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];

      List<MajorsData> majors = data.map((e) => MajorsData.fromJson(e)).toList();

      return majors;
    } else {
      print(response.reasonPhrase);
    }
    return [];
  }

  ValueNotifier<DateTime> selectedStartTimeNotifier = ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<DateTime> selectedDurationNotifier = ValueNotifier<DateTime>(DateTime.now());
  DateTime? selectedStartTimeDate;
  DateTime? selectedDurationDate;
  int? selectedDateMilliseconds;

  Future<void> _selectStartTimeDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartTimeDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedStartTimeDate = picked;
      });
    }
  }

  Future<void> _selectDurationDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDurationDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDurationDate = picked;
        selectedDateMilliseconds = picked.millisecondsSinceEpoch;
      });
    }
  }

  String? selectedTeacherValue;
  String? selectedClassValue;
  String? selectedMajorValue;

  final TextEditingController textTeacherEditingController = TextEditingController();
  final TextEditingController textClassEditingController = TextEditingController();
  final TextEditingController textMajorController = TextEditingController();

  final isLoading = false.obs;

  Future<void> _fetchCreate() async {
    isLoading(true);

    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse('https://backend-shool-project.onrender.com/timetable/create'));
      request.body = json.encode({
        "teacher_id": selectedTeacherValue,
        "class_id": selectedClassValue,
        "major_id": selectedMajorValue,
        "start_time": selectedStartTimeDate.toString(),
        "duration": selectedDateMilliseconds.toString()
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      final res = await json.decode(await response.stream.bytesToString());
      print(res);

      if (res['status'] == 'FAIL') {
        Get.snackbar(
          "Lỗi",
          "Thời khóa biểu đã được tạo.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (res['status'] == 'TEACHERFAIL') {
        Get.snackbar(
          "Lỗi",
          "Giáo viên không tồn tại.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (res['status'] == 'CLASSFAIL') {
        Get.snackbar(
          "Lỗi",
          "Lớp học không tồn tại.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (res['status'] == 'MAJORFAIL') {
        Get.snackbar(
          "Lỗi",
          "Môn học không tồn tại.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (res['status'] == 'SUCCESS') {
        Get.back();
        Get.snackbar(
          "Thành công",
          "Tạo thời khóa biểu thành công!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
    }

    isLoading(false);
  }

  @override
  void dispose() {
    textTeacherEditingController.dispose();
    textClassEditingController.dispose();
    textMajorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Tạo một lịch học theo một buổi',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Giáo viên',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
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
                      return Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Danh sách giáo viên',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: snapshot.data!
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.sId,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              item.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
                                            ),
                                            radius: 20,
                                          ),
                                          const SizedBox(width: 12),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.fullName ?? '',
                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                item.teacherCode ?? '',
                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            value: selectedTeacherValue,
                            onChanged: (value) {
                              setState(() {
                                selectedTeacherValue = value!;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 50,
                              width: double.maxFinite,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 500,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 60,
                            ),
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textTeacherEditingController.clear();
                              }
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Lớp học',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
                FutureBuilder<List<Classes>>(
                  future: _getClassInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Không có lớp học nào.'));
                    } else {
                      return Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Danh sách lớp học',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: snapshot.data!
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.id,
                                      child: Text(
                                        item.className.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedClassValue,
                            onChanged: (value) {
                              setState(() {
                                selectedClassValue = value;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 50,
                              width: double.maxFinite,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 500,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 60,
                            ),
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textClassEditingController.clear();
                              }
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Môn học',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
                FutureBuilder<List<MajorsData>>(
                  future: _getFetchMajors(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Không có môn học.'));
                    } else {
                      return Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Danh sách môn học',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: snapshot.data!
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.sId,
                                      child: Text(
                                        item.name.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedMajorValue,
                            onChanged: (value) {
                              setState(() {
                                selectedMajorValue = value;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 40,
                              width: double.maxFinite,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 500,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textMajorController.clear();
                              }
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Ngày môn học bắt đầu',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () async {
                      await _selectStartTimeDate(context);
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(DateFormat('dd/MM/yyyy').format(selectedStartTimeDate ?? DateTime.now())),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Ngày môn học kết thúc',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () async {
                      await _selectDurationDate(context);
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(DateFormat('dd/MM/yyyy').format(selectedDurationDate ?? DateTime.now())),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: InkWell(
                    onTap: () {
                      if (selectedTeacherValue == null ||
                          selectedClassValue == null ||
                          selectedMajorValue == null ||
                          selectedStartTimeDate == null ||
                          selectedDateMilliseconds == null) {
                        print(selectedTeacherValue);
                        Get.snackbar(
                          "Lỗi",
                          "Vui lòng chọn đủ thông tin.",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else {
                        _fetchCreate();
                      }
                    },
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.pink,
                      ),
                      child: isLoading.value
                          ? const Center(child: SizedBox(width: 19, height: 19, child: CircularProgressIndicator()))
                          : const Text(
                              'Thực hiện',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                    ),
                  ),
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
