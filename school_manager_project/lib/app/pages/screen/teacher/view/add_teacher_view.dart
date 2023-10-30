// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_manager_project/app/widgets/custom_text_widgets.dart';
import 'package:http/http.dart' as http;

class AddTeacherView extends StatefulWidget {
  const AddTeacherView({super.key});

  @override
  State<AddTeacherView> createState() => _AddTeacherViewState();
}

class _AddTeacherViewState extends State<AddTeacherView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController teacherCodeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController cccdController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController ethnicityController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController teachingLevelController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController joinDateController = TextEditingController();
  final TextEditingController civilServantController = TextEditingController();
  final TextEditingController contractTypeController = TextEditingController();
  final TextEditingController primarySubjectController = TextEditingController();
  final TextEditingController secondarySubjectController = TextEditingController();
  final TextEditingController isWorkingController = TextEditingController();
  final TextEditingController academicDegreeController = TextEditingController();
  final TextEditingController standardDegreeController = TextEditingController();
  final TextEditingController politicalTheoryController = TextEditingController();

  ValueNotifier<DateTime> selectedBirthDateNotifier = ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<DateTime> selectedJoinDateNotifier = ValueNotifier<DateTime>(DateTime.now());

  late bool isCivilServant = true;
  late bool isSeletedIsWorking = false;

  DateTime? selectedBirthDate;
  DateTime? selectedJoinDate;

  final isLoading = false.obs;

  Future<void> _selectDate(BuildContext context, String type) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
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

  Future<dynamic> addTeacher() async {
    isLoading(true);

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://backend-shool-project.onrender.com/admin/add'));
    request.body = json.encode({
      "fullName": fullNameController.text,
      "teacherCode": teacherCodeController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "phoneNumber": phoneNumberController.text,
      "gender": genderController.text,
      "cccd": cccdController.text,
      "birthDate": selectedBirthDateNotifier.value.toString(),
      "birthPlace": birthPlaceController.text,
      "ethnicity": ethnicityController.text,
      "nickname": nicknameController.text,
      "teachingLevel": teachingLevelController.text,
      "position": positionController.text,
      "experience": experienceController.text,
      "department": departmentController.text,
      "role": roleController.text,
      "joinDate": selectedJoinDateNotifier.value.toString(),
      "civilServant": isCivilServant.toString(),
      "contractType": contractTypeController.text,
      "primarySubject": primarySubjectController.text,
      "secondarySubject": secondarySubjectController.text,
      "isWorking": isSeletedIsWorking.toString(),
      "academicDegree": academicDegreeController.text,
      "standardDegree": standardDegreeController.text,
      "politicalTheory": politicalTheoryController.text,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final res = await json.decode(await response.stream.bytesToString());
    if (res['status'] == 'email_check') {
      Get.snackbar(
        "Thất bại",
        "Email đã tồn tại!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (res['status'] == 'phone_check') {
      Get.snackbar(
        "Thất bại",
        "Số điện thoại đã tồn tại!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (res['status'] == 'code_check') {
      Get.snackbar(
        "Thất bại",
        "Mã giáo viên đã tồn tại!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (res['status'] == 'cccd_check') {
      Get.snackbar(
        "Thất bại",
        "CCCD đã tồn tại!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (res['status'] == 'SUCCESS') {
      Get.snackbar(
        "Thành công",
        "Giáo viên đã được thêm thành công!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Navigator.of(context).pop();
    } else {
      Get.snackbar(
        "Thất bại",
        "Lỗi kết nối!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    isLoading(false);
  }

  @override
  void dispose() {
    super.dispose();

    fullNameController.dispose();
    teacherCodeController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    cccdController.dispose();
    birthDateController.dispose();
    birthPlaceController.dispose();
    ethnicityController.dispose();
    nicknameController.dispose();
    teachingLevelController.dispose();
    positionController.dispose();
    experienceController.dispose();
    departmentController.dispose();
    roleController.dispose();
    joinDateController.dispose();
    civilServantController.dispose();
    contractTypeController.dispose();
    primarySubjectController.dispose();
    secondarySubjectController.dispose();
    isWorkingController.dispose();
    academicDegreeController.dispose();
    standardDegreeController.dispose();
    politicalTheoryController.dispose();
    selectedBirthDateNotifier.dispose();
    selectedJoinDateNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Thêm giáo viên mới',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: SizedBox(
            width: double.maxFinite,
            child: Form(
              key: _formKey,
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
                  CustomTextWidgets(
                    controller: fullNameController,
                    isEditing: true.obs,
                    title: 'Họ và Tên',
                    initialData: '',
                    keyboardType: TextInputType.name,
                    validator: true,
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: teacherCodeController,
                    isEditing: true.obs,
                    title: 'Mã giáo viên',
                    initialData: '',
                    validator: true,
                  ),
                  CustomTextWidgets(
                    controller: passwordController,
                    isEditing: true.obs,
                    title: 'Mật khẩu',
                    initialData: '',
                    validator: true,
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: cccdController,
                    isEditing: true.obs,
                    title: 'CMND/CCCD',
                    initialData: '',
                    validator: true,
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: emailController,
                    isEditing: true.obs,
                    title: 'Email',
                    initialData: '',
                    keyboardType: TextInputType.emailAddress,
                    validator: true,
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: phoneNumberController,
                    isEditing: true.obs,
                    title: 'Số điện thoại',
                    initialData: '',
                    keyboardType: TextInputType.phone,
                    validator: true,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF9AA0AC)),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      // value: "genderController.text",
                      value: "Khác",
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
                        genderController.text = newValue!;
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
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
                                : '',
                            keyboardType: TextInputType.datetime,
                          );
                        }),
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: birthPlaceController,
                    isEditing: true.obs,
                    title: 'Nơi sinh',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: ethnicityController,
                    isEditing: true.obs,
                    title: 'Dân tộc',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: nicknameController,
                    isEditing: true.obs,
                    title: 'Biệt danh',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      '2. Thông công việc',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: teachingLevelController,
                    isEditing: true.obs,
                    title: 'Trình độ giảng dạy',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: positionController,
                    isEditing: true.obs,
                    title: 'Chức vụ',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: experienceController,
                    isEditing: true.obs,
                    title: 'Kinh nghiệm',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: departmentController,
                    isEditing: true.obs,
                    title: 'Bộ môn',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: roleController,
                    isEditing: true.obs,
                    title: 'Vai trò',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () async {
                      await _selectDate(context, 'join');
                    },
                    child: ValueListenableBuilder(
                        valueListenable: selectedJoinDateNotifier,
                        builder: (context, date, child) {
                          return CustomTextWidgets(
                            isEditing: RxBool(false),
                            title: 'Ngày tham gia',
                            initialData: selectedJoinDate != null
                                ? '${selectedJoinDate!.day}/${selectedJoinDate!.month}/${selectedJoinDate!.year}'
                                : '',
                            keyboardType: TextInputType.datetime,
                          );
                        }),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF9AA0AC)),
                    ),
                    child: DropdownButtonFormField<bool>(
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      // value: isCivilServant,
                      value: false,
                      elevation: 0,
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      padding: const EdgeInsets.only(left: 16, right: 24),
                      items: const [
                        DropdownMenuItem(
                          value: true,
                          child: Text('Có'),
                        ),
                        DropdownMenuItem(
                          value: false,
                          child: Text('Không'),
                        ),
                      ],
                      onChanged: (newValue) {
                        isCivilServant = newValue!;
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: contractTypeController,
                    isEditing: true.obs,
                    title: 'Loại hợp đồng',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: primarySubjectController,
                    isEditing: true.obs,
                    title: 'Môn dạy chính',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: secondarySubjectController,
                    isEditing: true.obs,
                    title: 'Môn dạy phụ',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF9AA0AC)),
                    ),
                    child: DropdownButtonFormField<bool>(
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      // value: isSeletedIsWorking,
                      value: true,
                      elevation: 0,
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      padding: const EdgeInsets.only(left: 16, right: 24),
                      items: const [
                        DropdownMenuItem(
                          value: true,
                          child: Text('Đang làm việc'),
                        ),
                        DropdownMenuItem(
                          value: false,
                          child: Text('Đã nghỉ làm'),
                        ),
                      ],
                      onChanged: (newValue) {
                        isSeletedIsWorking = newValue!;
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      '3. Trình độ chuyên môn',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: academicDegreeController,
                    isEditing: true.obs,
                    title: 'Trình độ học vấn',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: standardDegreeController,
                    isEditing: true.obs,
                    title: 'Trình độ chuẩn',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: politicalTheoryController,
                    isEditing: true.obs,
                    title: 'Chính trị',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addTeacher();
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                        child: isLoading.value
                            ? const Center(child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator()))
                            : const Text(
                                "Thêm giáo viên",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
