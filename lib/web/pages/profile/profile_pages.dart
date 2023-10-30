// ignore_for_file: unrelated_type_equality_checks, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:school_web/web/component_library/image_picker_dialog.dart';
import 'package:school_web/web/controllers/teacher/teacher_controller.dart';
import 'package:school_web/web/models/teacher.dart';
import 'package:school_web/web/widgets/custom_text_widgets.dart';
import 'package:school_web/web/widgets/full_screen_image_screen.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({super.key});

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> with SingleTickerProviderStateMixin {
  TeacherData? teacherData;
  final authController = Get.put(AuthenticationController());
  late final String? _selectedGender = authController.teacherData.value?.gender;

  late bool isCivilServant = authController.teacherData.value?.civilServant ?? true;
  late bool isSeletedIsWorking = authController.teacherData.value?.isWorking ?? false;

  ValueNotifier<DateTime> selectedBirthDateNotifier = ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<DateTime> selectedJoinDateNotifier = ValueNotifier<DateTime>(DateTime.now());

  DateTime? selectedBirthDate;
  DateTime? selectedJoinDate;

  String? selectedImagePath;

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

  Future<dynamic> updateAvatar() async {
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(
          'https://backend-shool-project.onrender.com/admin/edit-avatar/${authController.teacherData.value!.sId.toString()}'),
    );
    request.files.add(await http.MultipartFile.fromPath('file', selectedImagePath.toString()));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      Get.back();
      Get.snackbar(
        "Thành công",
        "Đổi ảnh đại diện thành công!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      print(await response.stream.bytesToString());
    } else {
      Get.snackbar(
        "Thất bại",
        "Lỗi đổi ảnh đại diện!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    authController.getProfileData();
    super.initState();
  }

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _cccdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _ethnicityController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _teachingLevelController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _civilServantController = TextEditingController();
  final TextEditingController _contractTypeController = TextEditingController();
  final TextEditingController _primarySubjectController = TextEditingController();
  final TextEditingController _secondarySubjectController = TextEditingController();
  final TextEditingController _academicDegreeController = TextEditingController();
  final TextEditingController _standardDegreeController = TextEditingController();
  final TextEditingController _politicalTheoryController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _cccdController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _genderController.dispose();
    _birthPlaceController.dispose();
    _ethnicityController.dispose();
    _nicknameController.dispose();
    _teachingLevelController.dispose();
    _positionController.dispose();
    _experienceController.dispose();
    _departmentController.dispose();
    _roleController.dispose();
    _civilServantController.dispose();
    _contractTypeController.dispose();
    _primarySubjectController.dispose();
    _secondarySubjectController.dispose();
    _academicDegreeController.dispose();
    _standardDegreeController.dispose();
    _politicalTheoryController.dispose();
    selectedBirthDateNotifier.dispose();
    selectedJoinDateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RxBool isEditing = RxBool(false);

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

    return Scaffold(
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
            Obx(
              () => Text(
                isEditing.value
                    ? 'Edit Profile'
                    : '${authController.teacherData.value?.fullName ?? ''} ${(authController.teacherData.value?.nickname ?? '').isEmpty ? '' : '('}${authController.teacherData.value?.nickname}${(authController.teacherData.value?.nickname ?? '').isEmpty ? '' : ')'}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Obx(() => IconButton(
                  onPressed: () async {
                    if (isEditing.value) {
                      await authController.getPutProfileTeacher(
                        _fullNameController.text,
                        _cccdController.text,
                        _emailController.text,
                        _phoneNumberController.text,
                        _genderController.text,
                        selectedBirthDateNotifier.value.toString(),
                        _birthPlaceController.text,
                        _ethnicityController.text,
                        _nicknameController.text,
                        _teachingLevelController.text,
                        _positionController.text,
                        _experienceController.text,
                        _departmentController.text,
                        _roleController.text,
                        selectedJoinDateNotifier.value.toString(),
                        isCivilServant.toString(),
                        _contractTypeController.text,
                        _primarySubjectController.text,
                        _secondarySubjectController.text,
                        isSeletedIsWorking.toString(),
                        _academicDegreeController.text,
                        _standardDegreeController.text,
                        _politicalTheoryController.text,
                      );
                    } else {
                      isEditing.value = true;
                    }
                  },
                  icon: Icon(isEditing.value ? Icons.save : Icons.edit, size: 20, color: Colors.black),
                )),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImageScreen(
                              imageUrl:
                                  authController.teacherData.value!.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
                            ),
                          ),
                        );
                      },
                      child:
                          // selectedImagePath != null
                          //     ? CircleAvatar(
                          //         backgroundImage: FileImage(File(selectedImagePath!)),
                          //         radius: 60,
                          //       )
                          //     :
                          CircleAvatar(
                        backgroundImage: NetworkImage(
                          authController.teacherData.value?.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
                        ),
                        radius: 60,
                      ),
                    ),
                    isEditing.value
                        ? Positioned(
                            bottom: 3,
                            right: 2,
                            child: SizedBox(
                              child: InkWell(
                                onTap: () async {
                                  // _showConfirmationDialog(ImagePickerDialog.imgFromGallery);
                                  final result = await ImagePickerDialog.imgFromGallery();
                                  if (result.isNotEmpty) {
                                    selectedImagePath = result[0];
                                    updateAvatar();
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1000),
                                    color: Colors.grey[400],
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(Icons.camera_alt, size: 16),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 8,
                  color: const Color(0xFFFAFAFA),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
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
                      isEditing == true
                          ? CustomTextWidgets(
                              controller: _fullNameController,
                              isEditing: isEditing,
                              title: 'Họ và Tên',
                              initialData: authController.teacherData.value?.fullName,
                              keyboardType: TextInputType.name,
                            )
                          : CustomTextWidgets(
                              isEditing: isEditing,
                              title: 'Mã giáo viên',
                              initialData: authController.teacherData.value?.teacherCode,
                              color: Colors.green,
                            ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _cccdController,
                        isEditing: isEditing,
                        title: 'CMND/CCCD',
                        initialData: authController.teacherData.value?.cccd,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _emailController,
                        isEditing: isEditing,
                        title: 'Email',
                        initialData: authController.teacherData.value?.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _phoneNumberController,
                        isEditing: isEditing,
                        title: 'Số điện thoại',
                        initialData: authController.teacherData.value?.phoneNumber,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 12),
                      isEditing == true
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFF9AA0AC)),
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                value: _selectedGender,
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
                                  _genderController.text = newValue!;
                                },
                              ),
                            )
                          : CustomTextWidgets(
                              controller: _genderController,
                              isEditing: isEditing,
                              title: 'Giới tính',
                              initialData: authController.teacherData.value?.gender,
                            ),
                      const SizedBox(height: 12),
                      isEditing == true
                          ? InkWell(
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
                                          : formattedBirthDate,
                                      keyboardType: TextInputType.datetime,
                                    );
                                  }),
                            )
                          : CustomTextWidgets(
                              isEditing: isEditing,
                              title: 'Ngày sinh',
                              // initialData: authController.teacherData.value?.birthDate,
                              keyboardType: TextInputType.datetime,
                              initialData: formattedBirthDate,
                            ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _birthPlaceController,
                        isEditing: isEditing,
                        title: 'Nơi sinh',
                        initialData: authController.teacherData.value?.birthPlace,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _ethnicityController,
                        isEditing: isEditing,
                        title: 'Dân tộc',
                        initialData: authController.teacherData.value?.ethnicity,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _nicknameController,
                        isEditing: isEditing,
                        title: 'Biệt danh',
                        initialData: authController.teacherData.value?.nickname,
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
                        controller: _teachingLevelController,
                        isEditing: isEditing,
                        title: 'Trình độ giảng dạy',
                        initialData: authController.teacherData.value?.teachingLevel,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _positionController,
                        isEditing: isEditing,
                        title: 'Chức vụ',
                        initialData: authController.teacherData.value?.position,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _experienceController,
                        isEditing: isEditing,
                        title: 'Kinh nghiệm',
                        initialData: authController.teacherData.value?.experience,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _departmentController,
                        isEditing: isEditing,
                        title: 'Bộ môn',
                        initialData: authController.teacherData.value?.department,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _roleController,
                        isEditing: isEditing,
                        title: 'Vai trò',
                        initialData: authController.teacherData.value?.role,
                      ),
                      const SizedBox(height: 12),
                      isEditing == true
                          ? InkWell(
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
                                          : formattedJoinDate,
                                      keyboardType: TextInputType.datetime,
                                    );
                                  }),
                            )
                          : CustomTextWidgets(
                              isEditing: isEditing,
                              title: 'Ngày tham gia',
                              // initialData: authController.teacherData.value?.joinDate,
                              keyboardType: TextInputType.datetime,
                              initialData: formattedJoinDate,
                            ),
                      const SizedBox(height: 12),
                      isEditing == true
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFF9AA0AC)),
                              ),
                              child: DropdownButtonFormField<bool>(
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                value: isCivilServant,
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
                            )
                          : CustomTextWidgets(
                              isEditing: isEditing,
                              title: 'Là cán bộ công chức',
                              initialData: authController.teacherData.value?.civilServant == true ? 'Có' : 'Không',
                            ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _contractTypeController,
                        isEditing: isEditing,
                        title: 'Loại hợp đồng',
                        initialData: authController.teacherData.value?.contractType,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _primarySubjectController,
                        isEditing: isEditing,
                        title: 'Môn dạy chính',
                        initialData: authController.teacherData.value?.primarySubject,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _secondarySubjectController,
                        isEditing: isEditing,
                        title: 'Môn dạy phụ',
                        initialData: authController.teacherData.value?.secondarySubject,
                      ),
                      const SizedBox(height: 12),
                      isEditing == true
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFF9AA0AC)),
                              ),
                              child: DropdownButtonFormField<bool>(
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                value: isSeletedIsWorking,
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
                            )
                          : CustomTextWidgets(
                              isEditing: isEditing,
                              title: 'Đang làm việc',
                              initialData:
                                  authController.teacherData.value?.isWorking == true ? 'Đang làm việc' : 'Đã nghỉ làm',
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
                        controller: _academicDegreeController,
                        isEditing: isEditing,
                        title: 'Trình độ học vấn',
                        initialData: authController.teacherData.value?.academicDegree,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _standardDegreeController,
                        isEditing: isEditing,
                        title: 'Trình độ chuẩn',
                        initialData: authController.teacherData.value?.standardDegree,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _politicalTheoryController,
                        isEditing: isEditing,
                        title: 'Chính trị',
                        initialData: authController.teacherData.value?.politicalTheory,
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

  Future<void> _showConfirmationDialog(dynamic pickImage) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận đổi ảnh đại diện', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          content: const Text(
            'Bạn xác nhận có muốn đổi ảnh đại diện',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
            TextButton(
              onPressed: () {
                pickImage();
                Navigator.of(context).pop();
              },
              child: const Text('Đồng ý', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }
}
