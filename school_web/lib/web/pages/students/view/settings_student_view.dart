import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/web/constants/style.dart';
import 'package:school_web/web/controllers/teacher/teacher_controller.dart';
import 'package:school_web/web/pages/students/view/widgets/reset_password.dart';
import 'package:school_web/web/widgets/show_dialog/confirm_logout_widget.dart';

class SettingsStudentView extends StatelessWidget {
  const SettingsStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthenticationController());

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
            const ResetPasswordStudentsView(),
            const SizedBox(height: 16),
            Center(
              child: InkWell(
                onTap: () {
                  confirmLogout(context, authController.logout);
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
                      'Đăng xuất',
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
}
