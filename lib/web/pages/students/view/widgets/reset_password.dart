import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ResetPasswordStudentsView extends StatefulWidget {
  const ResetPasswordStudentsView({super.key});

  @override
  State<ResetPasswordStudentsView> createState() => _ResetPasswordStudentsViewState();
}

class _ResetPasswordStudentsViewState extends State<ResetPasswordStudentsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formPassKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeOtpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  Future<dynamic> resetPass(String email) async {
    isLoading(true);

    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse('https://backend-shool-project.onrender.com/student/reset-password'));
      request.body = json.encode({"gmail": email});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      final res = await json.decode(await response.stream.bytesToString());
      if (res['status'] == 'emailExists') {
        Get.snackbar(
          "Thất bại",
          "Email không chính xác!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (res['status'] == 'SUCCESS') {
        Get.snackbar(
          "Thành công",
          "Kiểm tra email của bạn để đặt lại mật khẩu!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Navigator.of(context).pop();
        showRestPasswordAlert();
        emailController.clear();
      } else {
        Get.snackbar(
          "Thất bại",
          "Lỗi thao tác quá nhanh",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Lỗi$e');
    }

    isLoading(false);
  }

  Future<dynamic> recoverAccount(String otp, String newPass) async {
    isLoading(true);

    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse('https://backend-shool-project.onrender.com/student/recover-account'));
      request.body = json.encode({
        "verificationCode": otp,
        "newPassword": newPass,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      final res = await json.decode(await response.stream.bytesToString());
      if (res['status'] == 'verifiExists') {
        Get.snackbar(
          "Thất bại",
          "Mã xác minh không hợp lệ!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (res['status'] == 'expiredExists') {
        Get.snackbar(
          "Thất bại",
          "Mã xác minh đã hết hạn!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (res['status'] == 'SUCCESS') {
        Get.snackbar(
          "Thành công",
          "Đặt lại mật khẩu thành công",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Navigator.of(context).pop();
        codeOtpController.clear();
        newPasswordController.clear();
      } else {
        Get.snackbar(
          "Thất bại",
          "Lỗi thao tác quá nhanh",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Lỗi$e');
    }

    isLoading(false);
  }

  @override
  void dispose() {
    emailController.dispose();
    codeOtpController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDataAlert(context);
      },
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Đổi mật khẩu',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  showDataAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: const EdgeInsets.only(top: 10.0),
          title: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Đổi mật khẩu', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  'Nhập địa chỉ email của bạn bên dưới để nhận hướng dẫn đặt lại mật khẩu',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email không được để trống';
                        } else if (!value.contains('@')) {
                          return 'Email không hợp lệ';
                        }

                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          resetPass(emailController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                      child: isLoading.value
                          ? const Center(child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator()))
                          : const Text(
                              "Lấy lại mật khẩu",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showRestPasswordAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: const EdgeInsets.only(top: 10.0),
          title: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Xác nhận đổi mật khẩu",
                  ),
                ),
                const SizedBox(height: 8),
                Form(
                  key: _formPassKey,
                  child: Column(
                    children: [
                      SizedBox(
                        child: TextFormField(
                          controller: codeOtpController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                            hintText: 'Code otp',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Code otp không được để trống';
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => TextFormField(
                          controller: newPasswordController,
                          obscureText: !isPasswordVisible.value,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            border: const OutlineInputBorder(),
                            hintText: 'Mật khẩu mới',
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                isPasswordVisible.value = !isPasswordVisible.value;
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mật khẩu mới không được để trống';
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formPassKey.currentState!.validate()) {
                          recoverAccount(codeOtpController.text, newPasswordController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                      child: isLoading.value
                          ? const Center(child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator()))
                          : const Text(
                              "Change Password",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
