import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_web/web/models/teacher.dart';
import 'package:school_web/web/widgets/full_screen_image_screen.dart';

class TeacherDetailScreen extends StatelessWidget {
  const TeacherDetailScreen({required this.teacher, super.key});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    final birthDateJson = teacher.birthDate.toString();
    final joinDateJson = teacher.joinDate.toString();

    final dateFormatter = DateFormat('dd/MM/yyyy');
    DateTime? birthDate;
    if (birthDateJson.isNotEmpty) {
      birthDate = DateTime.tryParse(birthDateJson);
    }

    DateTime? joinDate;
    if (joinDateJson.isNotEmpty) {
      joinDate = DateTime.tryParse(joinDateJson);
    }

    final formattedBirthDate = birthDate != null ? dateFormatter.format(birthDate) : 'N/A';
    final formattedJoinDate = joinDate != null ? dateFormatter.format(joinDate) : 'N/A';

    late bool isCivilServant = teacher.civilServant ?? true;
    late bool isSeletedIsWorking = teacher.isWorking ?? false;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          teacher.fullName ?? '',
          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImageScreen(
                        imageUrl: teacher.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(teacher.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png'),
                  radius: 80,
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoItem('Mã giáo viên', teacher.teacherCode ?? ''),
              _buildInfoItem('Ngày sinh', formattedBirthDate),
              _buildInfoItem('Email', teacher.email ?? ''),
              _buildInfoItem('Số điện thoại', teacher.phoneNumber ?? ''),
              _buildInfoItem('Giới tính', teacher.gender ?? ''),
              _buildInfoItem('CCCD', teacher.cccd ?? ''),
              _buildInfoItem('Nơi sinh', teacher.birthPlace ?? ''),
              _buildInfoItem('Dân tộc', teacher.ethnicity ?? ''),
              _buildInfoItem('Biệt danh', teacher.nickname ?? ''),
              _buildInfoItem('Trình độ giảng dạy', teacher.teachingLevel ?? ''),
              _buildInfoItem('Vị trí', teacher.position ?? ''),
              _buildInfoItem('Kinh nghiệm', teacher.experience ?? ''),
              _buildInfoItem('Bộ môn', teacher.department ?? ''),
              _buildInfoItem('Chức vụ', teacher.role ?? ''),
              _buildInfoItem('Ngày tham gia', formattedJoinDate),
              _buildInfoItem('Là cán bộ công chức', isCivilServant ? 'Có' : 'Không'),
              _buildInfoItem('Loại hợp đồng', teacher.contractType ?? ''),
              _buildInfoItem('Môn học chính', teacher.primarySubject ?? ''),
              _buildInfoItem('Môn học phụ', teacher.secondarySubject ?? ''),
              _buildInfoItem('Đang làm việc', isSeletedIsWorking ? 'Đang làm việc' : 'Đã nghỉ làm'),
              _buildInfoItem('Trình độ học vấn', teacher.academicDegree ?? ''),
              _buildInfoItem('Trình độ chuẩn', teacher.standardDegree ?? ''),
              _buildInfoItem('Lý thuyết chính trị', teacher.politicalTheory ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
