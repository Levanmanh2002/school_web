import 'package:get/get.dart';

class DropdownController extends GetxController {
  var selectedTeacherValue = ''.obs;
  var selectedClassValue = ''.obs;
  var selectedMajorValue = ''.obs;

  void updateSelectedTeacher(String value) => selectedTeacherValue.value = value;
  void updateSelectedClass(String value) => selectedClassValue.value = value;
  void updateSelectedMajor(String value) => selectedMajorValue.value = value;
}
