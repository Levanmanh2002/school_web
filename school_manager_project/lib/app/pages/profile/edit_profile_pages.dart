import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_manager_project/app/component_library/image_picker_dialog.dart';
import 'package:school_manager_project/app/controllers/teacher/teacher_controller.dart';
import 'package:school_manager_project/app/models/teacher.dart';
import 'package:http/http.dart' as http;
import 'package:school_manager_project/app/widgets/custom_text_widgets.dart';
import 'package:school_manager_project/app/widgets/full_screen_image_screen.dart';

class EditProfilePages extends StatefulWidget {
  const EditProfilePages({super.key});

  @override
  State<EditProfilePages> createState() => _EditProfilePagesState();
}

class _EditProfilePagesState extends State<EditProfilePages> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
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
        'https://backend-shool-project.onrender.com/admin/edit-avatar/${authController.teacherData.value!.sId}',
      ),
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
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back, color: Colors.black)),
            const Text(
              'Cập nhật hồ sơ',
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
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
              }
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Lưu',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF0162E2)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 24),
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
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          authController.teacherData.value?.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
                        ),
                        radius: 60,
                      ),
                    ),
                    Positioned(
                      bottom: 3,
                      right: 2,
                      child: SizedBox(
                        child: InkWell(
                          onTap: () async {
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
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CustomTextWidgets(
                        controller: _fullNameController,
                        title: 'Họ và Tên',
                        keyboardType: TextInputType.name,
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _cccdController,
                        title: 'CMND/CCCD',
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _emailController,
                        title: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _phoneNumberController,
                        title: 'Số điện thoại',
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
                          value: _selectedGender,
                          elevation: 0,
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          padding: const EdgeInsets.only(left: 16, right: 24),
                          items: ["Nam", "Nữ", "Khác"].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF373A43),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            _genderController.text = newValue!;
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
                        child: ValueListenableBuilder<DateTime?>(
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
                                      : formattedBirthDate,
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
                        controller: _birthPlaceController,
                        title: 'Nơi sinh',
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _ethnicityController,
                        title: 'Dân tộc',
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _nicknameController,
                        title: 'Biệt danh',
                        validator: true,
                      ),
                      const SizedBox(height: 16),
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
                        title: 'Trình độ giảng dạy',
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _positionController,
                        title: 'Chức vụ',
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _experienceController,
                        title: 'Kinh nghiệm',
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _departmentController,
                        title: 'Bộ môn',
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _roleController,
                        title: 'Vai trò',
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Ngày tham gia',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF373A43)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          await _selectDate(context, 'join');
                        },
                        child: ValueListenableBuilder(
                          valueListenable: selectedJoinDateNotifier,
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
                                selectedJoinDate != null
                                    ? '${selectedJoinDate!.day}/${selectedJoinDate!.month}/${selectedJoinDate!.year}'
                                    : formattedJoinDate,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF373A43),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Là cán bộ công chức',
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
                        child: DropdownButtonFormField<bool>(
                          menuMaxHeight: 200,
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(bottom: 9),
                          ),
                          value: isCivilServant,
                          elevation: 0,
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          padding: const EdgeInsets.only(left: 16, right: 24),
                          items: const [
                            DropdownMenuItem(
                              value: true,
                              child: Text(
                                'Có',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF373A43)),
                              ),
                            ),
                            DropdownMenuItem(
                              value: false,
                              child: Text(
                                'Không',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF373A43)),
                              ),
                            ),
                          ],
                          onChanged: (newValue) {
                            isCivilServant = newValue!;
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _contractTypeController,
                        title: 'Loại hợp đồng',
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _primarySubjectController,
                        title: 'Môn dạy chính',
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _secondarySubjectController,
                        title: 'Môn dạy phụ',
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Tình trạng đang làm việc',
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
                        child: DropdownButtonFormField<bool>(
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(bottom: 9),
                          ),
                          value: isSeletedIsWorking,
                          elevation: 0,
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          padding: const EdgeInsets.only(left: 16, right: 24),
                          isExpanded: true,
                          alignment: Alignment.topCenter,
                          items: const [
                            DropdownMenuItem(
                              value: true,
                              child: Text(
                                'Đang làm việc',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF373A43)),
                              ),
                            ),
                            DropdownMenuItem(
                              value: false,
                              child: Text(
                                'Đã nghỉ làm',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF373A43)),
                              ),
                            ),
                          ],
                          onChanged: (newValue) {
                            isSeletedIsWorking = newValue!;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
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
                        title: 'Trình độ học vấn',
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _standardDegreeController,
                        title: 'Trình độ chuẩn',
                        validator: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextWidgets(
                        controller: _politicalTheoryController,
                        title: 'Chính trị',
                        validator: true,
                      ),
                      const SizedBox(height: 16),
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
