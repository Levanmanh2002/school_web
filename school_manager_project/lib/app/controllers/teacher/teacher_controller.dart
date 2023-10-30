import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_manager_project/app/controllers/auth_controller.dart';
import 'package:school_manager_project/app/models/teacher.dart';
import 'package:school_manager_project/app/routes/pages.dart';

class AuthenticationController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var rememberMe = false.obs;
  final Rx<TeacherData?> teacherData = Rx<TeacherData?>(null);

  void updateUsername(String value) {
    username.value = value;
  }

  void updatePassword(String value) {
    password.value = value;
  }

  void toggleRememberMe(bool value) {
    rememberMe.value = value;
  }

  final AuthController authController = Get.put(AuthController()); 

  Future<dynamic> getProfileData() async {
    final token = await const FlutterSecureStorage().read(key: 'token');

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('https://backend-shool-project.onrender.com/admin/profile'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      final jsonData = await response.stream.bytesToString();
      final teacher = Teacher.fromJson(json.decode(jsonData));

      teacherData.value = teacher.data;
    } else {
      print(response.reasonPhrase);
      logout();
    }
  }

  Future<dynamic> getPutProfileTeacher(
    String fullNameController,
    String cccdController,
    String emailController,
    String phoneNumberController,
    String genderController,
    String birthDateController,
    String birthPlaceController,
    String ethnicityController,
    String nicknameController,
    String teachingLevelController,
    String positionController,
    String experienceController,
    String departmentController,
    String roleController,
    String joinDateController,
    String civilServantController,
    String contractTypeController,
    String primarySubjectController,
    String secondarySubjectController,
    String isWorkingController,
    String academicDegreeController,
    String standardDegreeController,
    String politicalTheoryController,
  ) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('PUT',
          Uri.parse('https://backend-shool-project.onrender.com/admin/update/teacher/${teacherData.value?.teacherId}'));
      request.body = json.encode({
        "fullName": fullNameController,
        "email": emailController,
        "phoneNumber": phoneNumberController,
        "gender": genderController,
        "cccd": cccdController,
        "birthDate": birthDateController,
        "birthPlace": birthPlaceController,
        "ethnicity": ethnicityController,
        "nickname": nicknameController,
        "teachingLevel": teachingLevelController,
        "position": positionController,
        "experience": experienceController,
        "department": departmentController,
        "role": roleController,
        "joinDate": joinDateController,
        "civilServant": civilServantController,
        "contractType": contractTypeController,
        "primarySubject": primarySubjectController,
        "secondarySubject": secondarySubjectController,
        "isWorking": isWorkingController,
        "academicDegree": academicDegreeController, 
        "standardDegree": standardDegreeController,
        "politicalTheory": politicalTheoryController
      });
      print(request.body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);

      if (response.statusCode == 404) {
        return response.reasonPhrase.toString();
      } else if (response.statusCode == 201) {
        final jsonData = await response.stream.bytesToString();
        final teacher = Teacher.fromJson(json.decode(jsonData));

        teacherData.value = teacher.data;
        Get.back();
        Get.snackbar(
          "Thành công",
          "Cập nhật hồ sơ thành công!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        print("Cập nhật hồ sơ thành công.");
      } else {
        final responseData = await json.decode(await response.stream.bytesToString());
        final errorCode = responseData['status'];

        if (errorCode == 'check_email') {
          Get.snackbar(
            "Lỗi",
            "Email đã tồn tại.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          ); 
        } else if (errorCode == 'check_phone') {
          Get.snackbar(
            "Lỗi",
            "Số điện thoại đã tồn tại.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else if (errorCode == 'check_cccd') {
          Get.snackbar(
            "Lỗi",
            "CMND/CCCD đã tồn tại.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
        print(errorCode);
        print('.........' + errorCode);
      }
    } catch (e) {
      print("Lỗi: $e");
    }
  }

  Future<dynamic> logout() async {
    await const FlutterSecureStorage().delete(key: 'token');
    await Get.toNamed(Routes.SIGNIN);
    return Future.value(null);
  }
}
