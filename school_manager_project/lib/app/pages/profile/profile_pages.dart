// ignore_for_file: unrelated_type_equality_checks, unnecessary_null_comparison, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_manager_project/app/controllers/teacher/teacher_controller.dart';
import 'package:school_manager_project/app/models/teacher.dart';
import 'package:school_manager_project/app/routes/pages.dart';
import 'package:school_manager_project/app/widgets/custom_text_widgets.dart';
import 'package:school_manager_project/app/widgets/full_screen_image_screen.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({super.key});

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> with SingleTickerProviderStateMixin {
  TeacherData? teacherData;
  final authController = Get.put(AuthenticationController());

  @override
  void initState() {
    authController.getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final birthDateJson = authController.teacherData.value?.birthDate;
    final joinDateJson = authController.teacherData.value?.joinDate;

    final dateFormatter = DateFormat('dd/MM/yyyy');
    DateTime? birthDate;
    if (birthDateJson != null && birthDateJson.isNotEmpty) {
      birthDate = DateTime.tryParse(birthDateJson);
    }

    DateTime? joinDate;
    if (joinDateJson != null && joinDateJson.isNotEmpty) {
      joinDate = DateTime.tryParse(joinDateJson);
    }

    final formattedBirthDate = birthDate != null ? dateFormatter.format(birthDate) : 'N/A';
    final formattedJoinDate = joinDate != null ? dateFormatter.format(joinDate) : 'N/A';

    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
              const Text(
                'Thông tin cá nhân',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () async {
                  Get.toNamed(Routes.EDITPROFILR);
                },
                icon: const Icon(Icons.edit, size: 20, color: Colors.black),
              ),
            )
          ],
          bottom: TabBar(
            labelColor: const Color(0xFFFF0162E2),
            labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF7E8695)),
            indicatorSize: TabBarIndicatorSize.tab,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            dividerColor: Colors.red,
            splashBorderRadius: const BorderRadius.all(Radius.circular(8)),
            isScrollable: true,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xFFF2F3F5),
            ),
            unselectedLabelColor: const Color(0xFF7E8695),
            tabs: const [
              Tab(text: 'Thông tin chung'),
              Tab(text: 'Thông tin công việc'),
              Tab(text: 'Trình độ chuyên môn'),
            ],
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Obx(
            () => TabBarView(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImageScreen(
                                imageUrl: authController.teacherData.value!.avatarUrl ??
                                    'https://i.stack.imgur.com/l60Hf.png',
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            authController.teacherData.value?.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
                          ),
                          radius: 60,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            CustomTextWidgets(
                              title: 'Mã giáo viên',
                              initialData: authController.teacherData.value?.teacherCode,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Họ và Tên',
                              initialData: authController.teacherData.value?.fullName,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'CMND/CCCD',
                              initialData: authController.teacherData.value?.cccd,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Gmail',
                              initialData: authController.teacherData.value?.email,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Số điện thoại',
                              initialData: authController.teacherData.value?.phoneNumber,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Giới tính',
                              initialData: authController.teacherData.value?.gender,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Ngày sinh',
                              keyboardType: TextInputType.datetime,
                              initialData: formattedBirthDate,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Nơi sinh',
                              initialData: authController.teacherData.value?.birthPlace,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Dân tộc',
                              initialData: authController.teacherData.value?.ethnicity,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Biệt danh',
                              initialData: authController.teacherData.value?.nickname,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImageScreen(
                                imageUrl: authController.teacherData.value!.avatarUrl ??
                                    'https://i.stack.imgur.com/l60Hf.png',
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            authController.teacherData.value?.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
                          ),
                          radius: 60,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Trình độ giảng dạy',
                              initialData: authController.teacherData.value?.teachingLevel,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Chức vụ',
                              initialData: authController.teacherData.value?.position,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Kinh nghiệm',
                              initialData: authController.teacherData.value?.experience,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Bộ môn',
                              initialData: authController.teacherData.value?.department,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Vai trò',
                              initialData: authController.teacherData.value?.role,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Ngày tham gia',
                              initialData: formattedJoinDate,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Là cán bộ công chức',
                              initialData: authController.teacherData.value?.civilServant == true ? 'Có' : 'Không',
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Loại hợp đồng',
                              initialData: authController.teacherData.value?.contractType,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Môn dạy chính',
                              initialData: authController.teacherData.value?.primarySubject,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Môn dạy phụ',
                              initialData: authController.teacherData.value?.secondarySubject,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Đang làm việc',
                              initialData:
                                  authController.teacherData.value?.isWorking == true ? 'Đang làm việc' : 'Đã nghỉ làm',
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImageScreen(
                                imageUrl: authController.teacherData.value!.avatarUrl ??
                                    'https://i.stack.imgur.com/l60Hf.png',
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            authController.teacherData.value?.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
                          ),
                          radius: 60,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            CustomTextWidgets(
                              title: 'Trình độ học vấn',
                              initialData: authController.teacherData.value?.academicDegree,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Trình độ chuẩn',
                              initialData: authController.teacherData.value?.standardDegree,
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomTextWidgets(
                              title: 'Chính trị',
                              initialData: authController.teacherData.value?.politicalTheory,
                              enabled: false,
                            ),
                          ],
                        ),
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
