import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/web/constants/style.dart';
import 'package:school_web/web/routes/pages.dart';
import 'package:school_web/web/widgets/custom_card_widget.dart';

class StudentsPages extends StatelessWidget {
  const StudentsPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Get.toNamed(Routes.PROFILESTUDENT);
          },
          icon: Container(
            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(1000)),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.person, size: 16),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: dark),
            onPressed: () {
              Get.toNamed(Routes.SETTINGSSTUDENT);
            },
          ),
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              IconButton(icon: Icon(Icons.notifications, color: dark.withOpacity(0.7)), onPressed: () {}),
              Positioned(
                top: 12,
                right: 9,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: light, width: 2),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customCardWidgets(context, 'Thêm giáo viên mới', () {}),
                customCardWidgets(context, 'Thêm học sinh mới', () {}),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customCardWidgets(context, 'Danh sách giáo viên', () {}),
                customCardWidgets(context, 'Danh sách học sinh', () {}),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
