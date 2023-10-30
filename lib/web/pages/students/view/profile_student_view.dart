// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:school_web/web/component_library/image_picker_dialog.dart';
import 'package:school_web/web/controllers/student/student_controller.dart';
import 'package:school_web/web/controllers/teacher/teacher_controller.dart';
import 'package:school_web/web/models/student.dart';
import 'package:school_web/web/widgets/custom_text_widgets.dart';
import 'package:school_web/web/widgets/full_screen_image_screen.dart';

class ProfileStudentView extends StatefulWidget {
  const ProfileStudentView({super.key});

  @override
  State<ProfileStudentView> createState() => _ProfileStudentViewState();
}

class _ProfileStudentViewState extends State<ProfileStudentView> {
  final authController = Get.put(AuthenticationController());
  final studentController = Get.put(StudentController());
  final isLoading = false.obs;
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _cccdController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _customYearController = TextEditingController();
  final TextEditingController _mssvController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _hometownController = TextEditingController();
  final TextEditingController _permanentAddressController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _studentsController = TextEditingController();
  final TextEditingController _contactPhoneController = TextEditingController();
  final TextEditingController _contactAddressController = TextEditingController();
  final TextEditingController _educationLevelController = TextEditingController();
  final TextEditingController _academicPerformanceController = TextEditingController();
  final TextEditingController _conductController = TextEditingController();
  final TextEditingController _classRanking10Controller = TextEditingController();
  final TextEditingController _classRanking11Controller = TextEditingController();
  final TextEditingController _classRanking12Controller = TextEditingController();
  final TextEditingController _graduationYearController = TextEditingController();
  final TextEditingController _ethnicityController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _beneficiaryController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _idCardIssuedDateController = TextEditingController();
  final TextEditingController _idCardIssuedPlaceController = TextEditingController();
  final TextEditingController _fatherFullNameController = TextEditingController();
  final TextEditingController _motherFullNameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _isStudyingController = TextEditingController();

  late final String? _selectedGender = studentController.studentData.value?.gender;

  ValueNotifier<DateTime> selectedBirthDateNotifier = ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<DateTime> selectedJoinDateNotifier = ValueNotifier<DateTime>(DateTime.now());

  DateTime? selectedBirthDate;
  DateTime? selectedJoinDate;

  String? selectedImagePath;

  Future<void> _selectDate(BuildContext context, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      switch (type) {
        case 'birth':
          selectedBirthDateNotifier.value = picked;
          selectedBirthDate = picked;
          break;
        case 'join':
          selectedJoinDateNotifier.value = picked;
          selectedJoinDate = picked;
          break;
        default:
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileStudentData();
  }

  Future<dynamic> getProfileStudentData() async {
    final token = await const FlutterSecureStorage().read(key: 'token');

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('https://backend-shool-project.onrender.com/user/profile_student'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      final jsonData = await response.stream.bytesToString();
      final student = Student.fromJson(json.decode(jsonData));

      studentController.studentData.value = student.data;
    } else {
      print(response.reasonPhrase);
      authController.logout();
    }
  }

  Future<dynamic> updateAvatar() async {
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(
          'https://backend-shool-project.onrender.com/user/edit-avatar/${studentController.studentData.value!.sId}'),
    );
    request.files.add(await http.MultipartFile.fromPath('file', selectedImagePath.toString()));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      Get.back();
      Get.snackbar(
        "Thành công",
        "Đổi ảnh đại diện thành công!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      print(await response.stream.bytesToString());
    } else {
      Get.snackbar(
        "Thất bại",
        "Lỗi đổi ảnh đại diện!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(response.reasonPhrase);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _gmailController.dispose();
    _phoneController.dispose();
    _fullNameController.dispose();
    _birthDateController.dispose();
    _cccdController.dispose();
    _birthPlaceController.dispose();
    _customYearController.dispose();
    _mssvController.dispose();
    _genderController.dispose();
    _hometownController.dispose();
    _permanentAddressController.dispose();
    _occupationController.dispose();
    _studentsController.dispose();
    _contactPhoneController.dispose();
    _contactAddressController.dispose();
    _educationLevelController.dispose();
    _academicPerformanceController.dispose();
    _conductController.dispose();
    _classRanking10Controller.dispose();
    _classRanking11Controller.dispose();
    _classRanking12Controller.dispose();
    _graduationYearController.dispose();
    _ethnicityController.dispose();
    _religionController.dispose();
    _beneficiaryController.dispose();
    _areaController.dispose();
    _idCardIssuedDateController.dispose();
    _idCardIssuedPlaceController.dispose();
    _fatherFullNameController.dispose();
    _motherFullNameController.dispose();
    _notesController.dispose();
    _isStudyingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RxBool isEditing = RxBool(false);

    final birthDateJson = studentController.studentData.value?.birthDate;
    final idCardIssuedDateJson = studentController.studentData.value?.idCardIssuedDate;

    final dateFormatter = DateFormat('dd/MM/yyyy');
    DateTime? birthDate;
    if (birthDateJson != null && birthDateJson.isNotEmpty) {
      birthDate = DateTime.tryParse(birthDateJson);
    }

    DateTime? idCardIssuedDate;
    if (idCardIssuedDateJson != null && idCardIssuedDateJson.isNotEmpty) {
      idCardIssuedDate = DateTime.tryParse(idCardIssuedDateJson);
    }

    final formattedBirthDate = birthDate != null ? dateFormatter.format(birthDate) : 'N/A';
    final formCardIssuedDate = idCardIssuedDate != null ? dateFormatter.format(idCardIssuedDate) : 'N/A';

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back, size: 20, color: Colors.black)),
            Obx(
              () => Text(
                isEditing.value ? 'Edit Profile' : studentController.studentData.value?.fullName ?? '',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Obx(() => IconButton(
                  onPressed: () async {
                    if (isEditing.value) {
                      await studentController.getPutProfileStudent(
                        _gmailController.text,
                        _phoneController.text,
                        _fullNameController.text,
                        selectedBirthDateNotifier.value.toString(),
                        _cccdController.text,
                        _birthPlaceController.text,
                        _customYearController.text,
                        _genderController.text,
                        _hometownController.text,
                        _permanentAddressController.text,
                        _occupationController.text,
                        _contactPhoneController.text,
                        _contactAddressController.text,
                        _educationLevelController.text,
                        _academicPerformanceController.text,
                        _conductController.text,
                        _classRanking10Controller.text,
                        _classRanking11Controller.text,
                        _classRanking12Controller.text,
                        _graduationYearController.text,
                        _ethnicityController.text,
                        _religionController.text,
                        _beneficiaryController.text,
                        _areaController.text,
                        selectedJoinDateNotifier.value.toString(),
                        _idCardIssuedPlaceController.text,
                        _fatherFullNameController.text,
                        _motherFullNameController.text,
                        _notesController.text,
                      );
                    } else {
                      isEditing.value = true;
                    }
                  },
                  icon: Icon(isEditing.value ? Icons.save : Icons.edit, size: 20, color: Colors.black),
                )),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImageScreen(
                              imageUrl: studentController.studentData.value!.avatarUrl ??
                                  'https://i.stack.imgur.com/l60Hf.png',
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          studentController.studentData.value?.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
                        ),
                        radius: 60,
                      ),
                    ),
                    isEditing.value
                        ? Positioned(
                            bottom: 3,
                            right: 2,
                            child: SizedBox(
                              child: InkWell(
                                onTap: () async {
                                  final result = await ImagePickerDialog.imgFromGallery();
                                  if (result.isNotEmpty) {
                                    selectedImagePath = result[0];
                                    updateAvatar();
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1000),
                                    color: Colors.grey[400],
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(Icons.camera_alt, size: 16),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 8,
                  color: const Color(0xFFFAFAFA),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          '1. Thông tin chung',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 12),
                      isEditing == true
                          ? CustomTextWidgets(
                              controller: _fullNameController,
                              isEditing: isEditing,
                              title: 'Họ và Tên',
                              initialData: studentController.studentData.value?.fullName,
                              keyboardType: TextInputType.name,
                            )
                          : CustomTextWidgets(
                              isEditing: isEditing,
                              title: 'Mã sinh viên',
                              initialData: studentController.studentData.value?.mssv,
                              color: Colors.green,
                            ),
                      const SizedBox(height: 12),
                      isEditing == true
                          ? const SizedBox.shrink()
                          : CustomTextWidgets(
                              isEditing: isEditing,
                              title: 'Học sinh lớp',
                              initialData: studentController.studentData.value?.classStudent,
                              color: Colors.green,
                            ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _gmailController,
                        isEditing: isEditing,
                        title: 'Email',
                        initialData: studentController.studentData.value?.gmail,
                        keyboardType: TextInputType.emailAddress,
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _phoneController,
                        isEditing: isEditing,
                        title: 'Số điện thoại',
                        initialData: studentController.studentData.value?.phone,
                        keyboardType: TextInputType.phone,
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _cccdController,
                        isEditing: isEditing,
                        title: 'CMND/CCCD',
                        initialData: studentController.studentData.value?.cccd,
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      isEditing == true
                          ? InkWell(
                              onTap: () async {
                                await _selectDate(context, 'join');
                              },
                              child: ValueListenableBuilder(
                                  valueListenable: selectedJoinDateNotifier,
                                  builder: (context, date, child) {
                                    return CustomTextWidgets(
                                      isEditing: RxBool(false),
                                      title: 'Ngày cấp cmnd/cccd',
                                      initialData: selectedJoinDate != null
                                          ? '${selectedJoinDate!.day}/${selectedJoinDate!.month}/${selectedJoinDate!.year}'
                                          : formCardIssuedDate,
                                      keyboardType: TextInputType.datetime,
                                    );
                                  }),
                            )
                          : CustomTextWidgets(
                              controller: _idCardIssuedDateController,
                              isEditing: isEditing,
                              title: 'Ngày cấp cmnd/cccd',
                              initialData: formCardIssuedDate,
                            ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _idCardIssuedPlaceController,
                        isEditing: isEditing,
                        title: 'Nơi cấp cmnd/cccd',
                        initialData: studentController.studentData.value?.idCardIssuedPlace,
                      ),
                      const SizedBox(height: 12),
                      isEditing == true
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFF9AA0AC)),
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                value: _selectedGender,
                                elevation: 0,
                                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                                padding: const EdgeInsets.only(left: 16, right: 24),
                                items: ["Nam", "Nữ", "Khác"].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  _genderController.text = newValue!;
                                },
                              ),
                            )
                          : CustomTextWidgets(
                              controller: _genderController,
                              isEditing: isEditing,
                              title: 'Giới tính',
                              initialData: studentController.studentData.value?.gender,
                            ),
                      const SizedBox(height: 12),
                      isEditing == true
                          ? InkWell(
                              onTap: () async {
                                await _selectDate(context, 'birth');
                              },
                              child: ValueListenableBuilder(
                                  valueListenable: selectedBirthDateNotifier,
                                  builder: (context, date, child) {
                                    return CustomTextWidgets(
                                      isEditing: RxBool(false),
                                      title: 'Ngày sinh',
                                      initialData: selectedBirthDate != null
                                          ? '${selectedBirthDate!.day}/${selectedBirthDate!.month}/${selectedBirthDate!.year}'
                                          : formattedBirthDate,
                                      keyboardType: TextInputType.datetime,
                                    );
                                  }),
                            )
                          : CustomTextWidgets(
                              isEditing: isEditing,
                              title: 'Ngày sinh',
                              // initialData: studentController.studentData.value?.birthDate,
                              keyboardType: TextInputType.datetime,
                              initialData: formattedBirthDate,
                            ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _birthPlaceController,
                        isEditing: isEditing,
                        title: 'Nơi sinh',
                        initialData: studentController.studentData.value?.birthPlace,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _ethnicityController,
                        isEditing: isEditing,
                        title: 'Dân tộc',
                        initialData: studentController.studentData.value?.ethnicity,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _religionController,
                        isEditing: isEditing,
                        title: 'Tôn giáo',
                        initialData: studentController.studentData.value?.religion,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _hometownController,
                        isEditing: isEditing,
                        title: 'Quê quán học sinh',
                        initialData: studentController.studentData.value?.hometown,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _permanentAddressController,
                        isEditing: isEditing,
                        title: 'Địa chỉ thường trú học sinh',
                        initialData: studentController.studentData.value?.permanentAddress,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _contactAddressController,
                        isEditing: isEditing,
                        title: 'Địa chỉ liên lạc',
                        initialData: studentController.studentData.value?.contactAddress,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _beneficiaryController,
                        isEditing: isEditing,
                        title: 'Đối tượng học sinh (khu vực nào)',
                        initialData: studentController.studentData.value?.beneficiary,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _areaController,
                        isEditing: isEditing,
                        title: 'Khu vực',
                        initialData: studentController.studentData.value?.area,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _occupationController,
                        isEditing: isEditing,
                        title: 'Nghề nghiệp học sinh',
                        initialData: studentController.studentData.value?.occupation,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          '2. Thông học lực học sinh',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _customYearController,
                        isEditing: isEditing,
                        title: 'Năm vào học',
                        initialData: studentController.studentData.value?.customYear,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _educationLevelController,
                        isEditing: isEditing,
                        title: 'Trình độ học vấn',
                        initialData: studentController.studentData.value?.educationLevel,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _academicPerformanceController,
                        isEditing: isEditing,
                        title: 'Học lực học sinh',
                        initialData: studentController.studentData.value?.academicPerformance,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _conductController,
                        isEditing: isEditing,
                        title: 'Hạnh kiểm học sinh',
                        initialData: studentController.studentData.value?.conduct,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _classRanking10Controller,
                        isEditing: isEditing,
                        title: 'Học lực lớp 10',
                        initialData: studentController.studentData.value?.classRanking10,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _classRanking11Controller,
                        isEditing: isEditing,
                        title: 'Học lực lớp 11',
                        initialData: studentController.studentData.value?.classRanking11,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _classRanking12Controller,
                        isEditing: isEditing,
                        title: 'Học lực lớp 12',
                        initialData: studentController.studentData.value?.classRanking12,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _graduationYearController,
                        isEditing: isEditing,
                        title: 'Năm tốt nghiệp',
                        initialData: studentController.studentData.value?.graduationYear,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          '3. Thông học liên lạc',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _contactPhoneController,
                        isEditing: isEditing,
                        title: 'Số điện thoại liên lạc',
                        initialData: studentController.studentData.value?.contactPhone,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _fatherFullNameController,
                        isEditing: isEditing,
                        title: 'Họ tên Cha',
                        initialData: studentController.studentData.value?.fatherFullName,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _motherFullNameController,
                        isEditing: isEditing,
                        title: 'Họ tên Mẹ',
                        initialData: studentController.studentData.value?.motherFullName,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _notesController,
                        isEditing: isEditing,
                        title: 'Ghi chú',
                        initialData: studentController.studentData.value?.notes,
                      ),
                      const SizedBox(height: 12),
                      isEditing == true
                          ? const SizedBox.shrink()
                          : CustomTextWidgets(
                              isEditing: isEditing,
                              title: 'Tình trạng học sinh',
                              initialData: studentController.studentData.value?.isStudying == true
                                  ? 'Học sinh đang học'
                                  : 'Học sinh đã nghỉ học',
                            ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
