import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_web/web/controllers/auth_controller.dart';
import 'package:school_web/web/models/student.dart';

class StudentController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  final Rx<StudentData?> studentData = Rx<StudentData?>(null);

  Future<dynamic> getPutProfileStudent(
    String gmailController,
    String phoneController,
    String fullNameController,
    String selectedBirthDateNotifier,
    String cccdController,
    String birthPlaceController,
    String customYearController,
    String genderController,
    String hometownController,
    String permanentAddressController,
    String occupationController,
    String contactPhoneController,
    String contactAddressController,
    String educationLevelController,
    String academicPerformanceController,
    String conductController,
    String classRanking10Controller,
    String classRanking11Controller,
    String classRanking12Controller,
    String graduationYearController,
    String ethnicityController,
    String religionController,
    String beneficiaryController,
    String areaController,
    String selectedJoinDateNotifier,
    String idCardIssuedPlaceController,
    String fatherFullNameController,
    String motherFullNameController,
    String notesController,
  ) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
        'PUT',
        Uri.parse('https://backend-shool-project.onrender.com/user/update/student/${studentData.value?.studentId}'),
      );
      request.body = json.encode({
        "gmail": gmailController,
        "phone": phoneController,
        "fullName": fullNameController,
        "birthDate": selectedBirthDateNotifier,
        "cccd": cccdController,
        "birthPlace": birthPlaceController,
        "customYear": customYearController,
        "gender": genderController,
        "hometown": hometownController,
        "permanentAddress": permanentAddressController,
        "occupation": occupationController,
        "contactPhone": contactPhoneController,
        "contactAddress": contactAddressController,
        "educationLevel": educationLevelController,
        "academicPerformance": academicPerformanceController,
        "conduct": conductController,
        "classRanking10": classRanking10Controller,
        "classRanking11": classRanking11Controller,
        "classRanking12": classRanking12Controller,
        "graduationYear": graduationYearController,
        "ethnicity": ethnicityController,
        "religion": religionController,
        "beneficiary": beneficiaryController,
        "area": areaController,
        "idCardIssuedDate": selectedJoinDateNotifier,
        "idCardIssuedPlace": idCardIssuedPlaceController,
        "fatherFullName": fatherFullNameController,
        "motherFullName": motherFullNameController,
        "notes": notesController,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      final res = await json.decode(await response.stream.bytesToString());

      print(res);

      if (res['status'] == 'no_student') {
        Get.snackbar(
          "Lỗi",
          "Không tìm thấy sinh viên.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (res['status'] == 'check_gmail') {
        Get.snackbar(
          "Lỗi",
          "Email đã tồn tại.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (res['status'] == 'check_phone') {
        Get.snackbar(
          "Lỗi",
          "Số điện thoại đã tồn tại.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (res['status'] == 'check_cccd') {
        Get.snackbar(
          "Lỗi",
          "CMND/CCCD đã tồn tại.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (res['status'] == 'SUCCESS') {
        Get.back();
        Get.snackbar(
          "Thành công",
          "Cập nhật hồ sơ thành công!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Lỗi: $e");
    }
  }
}
