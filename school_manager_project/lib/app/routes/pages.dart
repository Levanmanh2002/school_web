import 'package:get/get.dart';
import 'package:school_manager_project/app/pages/authentication/authentication.dart';
import 'package:school_manager_project/app/pages/home/home_pages.dart';
import 'package:school_manager_project/app/pages/majors/majors_pages.dart';
import 'package:school_manager_project/app/pages/profile/edit_profile_pages.dart';
import 'package:school_manager_project/app/pages/profile/profile_pages.dart';
import 'package:school_manager_project/app/pages/screen/classes/view/class_info_view.dart';
import 'package:school_manager_project/app/pages/screen/classes/view/divide_classes_view.dart';
import 'package:school_manager_project/app/pages/screen/student/view/add_student_view.dart';
import 'package:school_manager_project/app/pages/screen/student/view/get_student_view.dart';
import 'package:school_manager_project/app/pages/screen/teacher/view/add_teacher_view.dart';
import 'package:school_manager_project/app/pages/screen/teacher/view/get_teachers_view.dart';
import 'package:school_manager_project/app/pages/setting/setting_pages.dart';
import 'package:school_manager_project/app/pages/students/students_pages.dart';
import 'package:school_manager_project/app/pages/students/view/profile_student_view.dart';
import 'package:school_manager_project/app/pages/students/view/settings_student_view.dart';
import 'package:school_manager_project/app/pages/timetable/timetable.dart';
import 'package:school_manager_project/app/pages/timetable/view/create_view.dart';

part 'routes.dart';

abstract class AppPages {
  static final pages = [
    // Teacher
    GetPage(
      name: Routes.SIGNIN,
      page: () => const AuthenticationPage(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePages(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfilePages(),
    ),
    GetPage(
      name: Routes.SETTING,
      page: () => const SettingPages(),
    ),
    GetPage(
      name: Routes.ADDTEACHER,
      page: () => const AddTeacherView(),
    ),
    GetPage(
      name: Routes.GETTEACHER,
      page: () => const GetTeachersView(),
    ),
    GetPage(
      name: Routes.GETMAJORS,
      page: () => const MajorsPages(),
    ),
    GetPage(
      name: Routes.ADDSTUDENT,
      page: () => const AddStudentView(),
    ),
    GetPage(
      name: Routes.GETSTUDENT,
      page: () => const GetStudentView(),
    ),
    GetPage(
      name: Routes.CLASSESINFO,
      page: () => const ClassesInfoView(),
    ),
    GetPage(
      name: Routes.DIVIDECLASS,
      page: () => const DivideClassesView(),
    ),
    GetPage(
      name: Routes.EDITPROFILR,
      page: () => const EditProfilePages(),
    ),

    // Students
    GetPage(
      name: Routes.HOMESTUDENT,
      page: () => const StudentsPages(),
    ),
    GetPage(
      name: Routes.PROFILESTUDENT,
      page: () => const ProfileStudentView(),
    ),
    GetPage(
      name: Routes.SETTINGSSTUDENT,
      page: () => const SettingsStudentView(),
    ),

    // Timetable
    GetPage(
      name: Routes.TIMETABLE,
      page: () => const TimetablePage(),
    ),
    GetPage(
      name: Routes.CREATE,
      page: () => const CreateView(),
    ),
  ];
}
