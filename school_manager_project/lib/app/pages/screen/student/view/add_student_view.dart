// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_manager_project/app/widgets/custom_text_widgets.dart';
import 'package:http/http.dart' as http;

class AddStudentView extends StatefulWidget {
  const AddStudentView({super.key});

  @override
  State<AddStudentView> createState() => _AddStudentViewState();
}

class _AddStudentViewState extends State<AddStudentView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController gmailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController cccdController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController customYearController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController hometownController = TextEditingController();
  final TextEditingController permanentAddressController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  // final TextEditingController classController = TextEditingController();
  final TextEditingController contactPhoneController = TextEditingController();
  final TextEditingController contactAddressController = TextEditingController();
  final TextEditingController educationLevelController = TextEditingController();
  // final TextEditingController graduationCertificateController = TextEditingController();
  final TextEditingController academicPerformanceController = TextEditingController();
  final TextEditingController conductController = TextEditingController();
  final TextEditingController classRanking10Controller = TextEditingController();
  final TextEditingController classRanking11Controller = TextEditingController();
  final TextEditingController classRanking12Controller = TextEditingController();
  final TextEditingController graduationYearController = TextEditingController();
  final TextEditingController ethnicityController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController beneficiaryController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController idCardIssuedDateController = TextEditingController();
  final TextEditingController idCardIssuedPlaceController = TextEditingController();
  final TextEditingController fatherFullNameController = TextEditingController();
  final TextEditingController motherFullNameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  ValueNotifier<DateTime> selectedBirthDateNotifier = ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<DateTime> selectedDateCccdNotifier = ValueNotifier<DateTime>(DateTime.now());

  late bool isCivilServant = true;
  late bool isSeletedIsWorking = false;

  DateTime? selectedBirthDate;
  DateTime? selectedDateCccd;

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
        case 'data_cccd':
          selectedDateCccdNotifier.value = picked;
          selectedDateCccd = picked;
          break;
        default:
          break;
      }
    }
  }

  Future<dynamic> addStudent() async {
    isLoading(true);

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://backend-shool-project.onrender.com/admin/signup'));
    request.body = json.encode({
      "fullName": fullNameController.text,
      "gmail": gmailController.text,
      "phone": phoneController.text,
      "birthDate": birthDateController.text,
      "cccd": cccdController.text,
      "birthPlace": birthPlaceController.text,
      "customYear": customYearController.text,
      "gender": genderController.text,
      "hometown": hometownController.text,
      "permanentAddress": permanentAddressController.text,
      "occupation": occupationController.text,
      "contactPhone": contactPhoneController.text,
      "contactAddress": contactAddressController.text,
      "educationLevel": educationLevelController.text,
      "academicPerformance": academicPerformanceController.text,
      "conduct": conductController.text,
      "classRanking10": classRanking10Controller.text,
      "classRanking11": classRanking11Controller.text,
      "classRanking12": classRanking12Controller.text,
      "graduationYear": graduationYearController.text,
      "ethnicity": ethnicityController.text,
      "religion": religionController.text,
      "beneficiary": beneficiaryController.text,
      "area": areaController.text,
      "idCardIssuedDate": idCardIssuedDateController.text,
      "idCardIssuedPlace": idCardIssuedPlaceController.text,
      "fatherFullName": fatherFullNameController.text,
      "motherFullName": motherFullNameController.text,
      "notes": notesController.text,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final res = await json.decode(await response.stream.bytesToString());

    if (res['status'] == 'check_email') {
      Get.snackbar(
        "Thất bại",
        "Email đã tồn tại!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (res['status'] == 'check_phone') {
      Get.snackbar(
        "Thất bại",
        "Số điện thoại đã tồn tại!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (res['status'] == 'check_cccd') {
      Get.snackbar(
        "Thất bại",
        "CCCD đã tồn tại!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (res['status'] == 'SUCCESS') {
      Get.snackbar(
        "Thành công",
        "Học sinh đã được thêm thành công, kiểm tra email của bạn để biết thông tin tài khoản!",
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
    gmailController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    cccdController.dispose();
    birthPlaceController.dispose();
    customYearController.dispose();
    genderController.dispose();
    hometownController.dispose();
    permanentAddressController.dispose();
    occupationController.dispose();
    // classController.dispose();
    contactPhoneController.dispose();
    contactAddressController.dispose();
    educationLevelController.dispose();
    // graduationCertificateController.dispose();
    academicPerformanceController.dispose();
    conductController.dispose();
    classRanking10Controller.dispose();
    classRanking11Controller.dispose();
    classRanking12Controller.dispose();
    graduationYearController.dispose();
    ethnicityController.dispose();
    religionController.dispose();
    beneficiaryController.dispose();
    areaController.dispose();
    idCardIssuedDateController.dispose();
    idCardIssuedPlaceController.dispose();
    fatherFullNameController.dispose();
    motherFullNameController.dispose();
    notesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back, size: 16)),
            const Text(
              'Thêm học sinh mới',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addStudent();
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                child: isLoading.value
                    ? const Center(child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator()))
                    : const Text(
                        "Thêm",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
              ),
            ),
          ),
        ],
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
                      '1. Thông tin học sinh',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: fullNameController,
                    title: 'Họ và Tên',
                    keyboardType: TextInputType.name,
                    validator: true,
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: customYearController,
                    title: 'Năm vào học',
                    keyboardType: TextInputType.name,
                    validator: true,
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: gmailController,
                    title: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: true,
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: cccdController,
                    title: 'CMND/CCCD',
                    validator: true,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Ngày cấp CCCD/CMND',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF373A43)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      await _selectDate(context, 'data_cccd');
                    },
                    child: ValueListenableBuilder(
                        valueListenable: selectedDateCccdNotifier,
                        builder: (context, date, child) {
                          return Container(
                            width: double.maxFinite,
                            height: 40,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFD2D5DA)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              selectedDateCccd != null
                                  ? '${selectedDateCccd!.day}/${selectedDateCccd!.month}/${selectedDateCccd!.year}'
                                  : 'N/A',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF373A43),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: idCardIssuedPlaceController,
                    title: 'Nơi cấp CCCD/CMND',
                    initialData: '',
                    validator: true,
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: phoneController,
                    title: 'Số điện thoại',
                    initialData: '',
                    keyboardType: TextInputType.phone,
                    validator: true,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Giới tính',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF373A43)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF9AA0AC)),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 9),
                      ),
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
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Ngày tháng năm sinh',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF373A43)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      await _selectDate(context, 'birth');
                    },
                    child: ValueListenableBuilder(
                        valueListenable: selectedBirthDateNotifier,
                        builder: (context, date, child) {
                          return Container(
                            width: double.maxFinite,
                            height: 40,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFD2D5DA)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              selectedBirthDate != null
                                  ? '${selectedBirthDate!.day}/${selectedBirthDate!.month}/${selectedBirthDate!.year}'
                                  : 'N/A',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF373A43),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: birthPlaceController,
                    title: 'Nơi sinh',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: ethnicityController,
                    title: 'Dân tộc',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: religionController,
                    title: 'Tôn giáo',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: hometownController,
                    title: 'Quê quán',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: permanentAddressController,
                    title: 'Địa chỉ thường trú',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: notesController,
                    title: 'Ghi chú',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      '2. Trình độ học vấn',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: educationLevelController,
                    title: 'Trình độ học vấn',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: academicPerformanceController,
                    title: 'Học lực',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: conductController,
                    title: 'Hạnh kiểm',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: classRanking10Controller,
                    title: 'Học lực lớp 10',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: classRanking11Controller,
                    title: 'Học lực lớp 11',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: classRanking12Controller,
                    title: 'Học lực lớp 12',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: graduationYearController,
                    title: 'Năm học tốt nghiệp',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: occupationController,
                    title: 'Nghề nghiệp học sinh',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      '3. Thông tin liên hệ',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: contactPhoneController,
                    title: 'Số điện thoại liên lạc',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: contactAddressController,
                    title: 'Địa chỉ liên lạc',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: fatherFullNameController,
                    title: 'Họ tên Cha',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: motherFullNameController,
                    title: 'Họ tên Mẹ',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: beneficiaryController,
                    title: 'Đối tượng học sinh ở đâu',
                    initialData: '',
                  ),
                  const SizedBox(height: 12),
                  CustomTextWidgets(
                    controller: areaController,
                    title: 'Khu vực',
                    initialData: '',
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
