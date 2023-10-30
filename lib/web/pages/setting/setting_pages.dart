import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_web/web/constants/style.dart';
import 'package:school_web/web/controllers/teacher/teacher_controller.dart';
import 'package:school_web/web/pages/screen/teacher/view/reset_password.dart';

class SettingPages extends StatefulWidget {
  const SettingPages({super.key});

  @override
  State<SettingPages> createState() => _SettingPagesState();
}

class _SettingPagesState extends State<SettingPages> {
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthenticationController());

    Future<dynamic> deleteTeacher() async {
      var request = http.Request(
        'DELETE',
        Uri.parse(
            'https://backend-shool-project.onrender.com/admin/delete-teacher/${authController.teacherData.value?.teacherId}'),
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        print(await response.stream.bytesToString());
        Get.snackbar(
          "Thành công",
          "Tài khoản giáo viên đã được xóa thành công!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        authController.logout();
      } else {
        Get.snackbar(
          "Thất bại",
          "Lỗi khi xóa tài khoản giáo viên!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(response.reasonPhrase);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: dark),
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: dark),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const ResetPasswordView(),
            const SizedBox(height: 16),
            Center(
              child: InkWell(
                onTap: () {
                  _showDeleteConfirmationDialog(deleteTeacher);
                },
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Xóa tài khoản',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDeleteConfirmationDialog(dynamic deleteTeacher) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa tài khoản', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          content: const Text(
            'Bạn có chắc chắn muốn xóa tài khoản này?',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                deleteTeacher();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Xác nhận',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
