import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_web/web/constants/style.dart';
import 'package:school_web/web/controllers/teacher/teacher_controller.dart';
import 'package:school_web/web/models/student.dart';
import 'package:school_web/web/pages/screen/student/detail/student_detail_screen.dart';
import 'package:school_web/web/routes/pages.dart';
import 'package:school_web/web/widgets/custom_card_widget.dart';
import 'package:school_web/web/widgets/full_screen_image_screen.dart';
import 'package:school_web/web/widgets/show_dialog/confirm_logout_widget.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final searchController = TextEditingController();
  final authController = Get.put(AuthenticationController());
  double value = 0;
  bool _isClearIconVisible = false;
  final isLoading = false.obs;
  String errorMessage = '';

  @override
  void initState() {
    authController.getProfileData();
    searchController.addListener(_onTextChanged);
    super.initState();
  }

  void _onTextChanged() {
    setState(() {
      _isClearIconVisible = searchController.text.isNotEmpty;
    });
  }

  StudentData? student;

  Future<void> fetchData(String query) async {
    isLoading(true);

    try {
      final response = await http.get(Uri.parse('https://backend-shool-project.onrender.com/user/check/$query'));

      if (response.statusCode == 404) {
        setState(() {
          errorMessage = 'Không tìm thấy học sinh';
          student = null;
        });
      } else if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        final studentData = jsonData['student'];

        setState(() {
          student = StudentData.fromJson(studentData);
          errorMessage = '';
        });
      } else {
        print('Failed to fetch data: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Lỗi: $e';
        student = null;
      });
    }

    isLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.pink.shade400,
                  Colors.pink.shade800,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Obx(
            () => SafeArea(
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    DrawerHeader(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                              radius: 50,
                              backgroundImage: NetworkImage(
                                authController.teacherData.value?.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            authController.teacherData.value?.fullName ?? '',
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            onTap: () {
                              Get.toNamed(Routes.HOME);
                              setState(() {
                                value = 0;
                              });
                            },
                            leading: const Icon(Icons.home, color: Colors.white),
                            title: const Text('Home', style: TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            onTap: () {
                              Get.toNamed(Routes.PROFILE);
                              setState(() {
                                value = 0;
                              });
                            },
                            leading: const Icon(Icons.home, color: Colors.white),
                            title: const Text('Profile', style: TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            onTap: () {
                              confirmLogout(context, authController.logout);
                            },
                            leading: const Icon(Icons.logout, color: Colors.white),
                            title: const Text('Log out', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: value),
            duration: const Duration(milliseconds: 500),
            builder: (_, double val, __) {
              return (Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, 200 * val)
                  ..rotateY((pi / 6) * val),
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    iconTheme: const IconThemeData(color: Colors.black),
                    leading: IconButton(
                      onPressed: () {
                        setState(() {
                          value == 0 ? value = 1 : value = 0;
                        });
                      },
                      icon: const Icon(Icons.menu_open_rounded),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.settings, color: dark),
                        onPressed: () {
                          Get.toNamed(Routes.SETTING);
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: searchController,
                              onChanged: fetchData,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: "Search",
                                suffixIcon: _isClearIconVisible
                                    ? IconButton(
                                        onPressed: () {
                                          searchController.clear();
                                          student = null;
                                        },
                                        icon: const Icon(Icons.clear))
                                    : null,
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              const SizedBox(height: 16),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      customCardWidgets(context, 'Thêm giáo viên mới', () {
                                        Get.toNamed(Routes.ADDTEACHER);
                                      }),
                                      customCardWidgets(context, 'Thêm học sinh mới', () {
                                        Get.toNamed(Routes.ADDSTUDENT);
                                      }),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      customCardWidgets(context, 'Danh sách giáo viên', () {
                                        Get.toNamed(Routes.GETTEACHER);
                                      }),
                                      customCardWidgets(context, 'Danh sách học sinh', () {
                                        Get.toNamed(Routes.GETSTUDENT);
                                      }),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      customCardWidgets(context, 'Danh sách các ngành học', () {
                                        Get.toNamed(Routes.GETMAJORS);
                                      }),
                                      customCardWidgets(context, 'Danh sách lớp học', () {
                                        Get.toNamed(Routes.CLASSESINFO);
                                      }),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      customCardWidgets(context, 'Kiểm tra lớp học chưa có giáo viên', () {}),
                                      customCardWidgets(context, 'Thêm giáo viên vào lớp học', () {}),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      customCardWidgets(context, 'Thêm học sinh vào lớp học', () {
                                        Get.toNamed(Routes.DIVIDECLASS);
                                      }),
                                      customCardWidgets(context, 'Thêm giáo viên vào lớp học', () {}),
                                    ],
                                  ),
                                ],
                              ),
                              if (_isClearIconVisible)
                                Container(
                                  width: double.maxFinite,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      if (errorMessage.isNotEmpty)
                                        Text(
                                          errorMessage,
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      if (student != null)
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Card(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                elevation: 1,
                                                color: Colors.white,
                                                child: ListTile(
                                                  leading: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => FullScreenImageScreen(
                                                            imageUrl: student?.avatarUrl ??
                                                                'https://i.stack.imgur.com/l60Hf.png',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                        student?.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
                                                      ),
                                                      radius: 30,
                                                    ),
                                                  ),
                                                  title: Text(
                                                    student?.fullName ?? '',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  subtitle: Text(student?.mssv ?? ''),
                                                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => StudentDetailScreen(student: student!),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
            },
          ),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              if (e.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
