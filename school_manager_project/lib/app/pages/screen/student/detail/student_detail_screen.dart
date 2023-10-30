import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_manager_project/app/models/student.dart';
import 'package:school_manager_project/app/widgets/full_screen_image_screen.dart';

class StudentDetailScreen extends StatelessWidget {
  const StudentDetailScreen({required this.student, super.key});

  final StudentData student;

  @override
  Widget build(BuildContext context) {
    late bool isStudying = student.isStudying ?? true;

    final birthDateJson = student.birthDate.toString();
    final idCardIssuedDateJson = student.idCardIssuedDate.toString();

    final dateFormatter = DateFormat('dd/MM/yyyy');

    DateTime? birthDate;
    if (birthDateJson.isNotEmpty) {
      birthDate = DateTime.tryParse(birthDateJson);
    }

    DateTime? idCardIssuedDate;
    if (idCardIssuedDateJson.isNotEmpty) {
      idCardIssuedDate = DateTime.tryParse(idCardIssuedDateJson);
    }

    final formattedBirthDate = birthDate != null ? dateFormatter.format(birthDate) : 'N/A';
    final formCardIssuedDate = idCardIssuedDate != null ? dateFormatter.format(idCardIssuedDate) : 'N/A';
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          student.fullName ?? '',
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
                        imageUrl: student.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(student.avatarUrl ?? 'https://i.stack.imgur.com/l60Hf.png'),
                  radius: 80,
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoItem('Mã số sinh viên', student.mssv ?? ''),
              _buildInfoItem('Gmail', student.gmail ?? ''),
              _buildInfoItem('Số điện thoại', student.phone ?? ''),
              _buildInfoItem('Năm sinh học sinh', formattedBirthDate),
              _buildInfoItem('Căn cước công dân', student.cccd ?? ''),
              _buildInfoItem('Nơi sinh học sinh', student.birthPlace ?? ''),
              _buildInfoItem('Năm vào học', student.customYear ?? ''),
              _buildInfoItem('Giới tính học sinh', student.gender ?? ''),
              _buildInfoItem('Quê quán học sinh', student.hometown ?? ''),
              _buildInfoItem('Địa chỉ thường trú học sinh', student.permanentAddress ?? ''),
              _buildInfoItem('Nghề nghiệp học sinh', student.occupation ?? ''),
              _buildInfoItem('Số điện thoại liên lạc', student.contactPhone ?? ''),
              _buildInfoItem('Địa chỉ liên lạc', student.contactAddress ?? ''),
              _buildInfoItem('Trình độ học vấn', student.educationLevel ?? ''),
              _buildInfoItem('Học lực học sinh', student.academicPerformance ?? ''),
              _buildInfoItem('Hạnh kiểm học sinh', student.conduct ?? ''),
              _buildInfoItem('học lực lớp 10', student.classRanking10 ?? ''),
              _buildInfoItem('học lực lớp 11', student.classRanking11 ?? ''),
              _buildInfoItem('học lực lớp 12', student.classRanking12 ?? ''),
              _buildInfoItem('Năm tốt nghiệp', student.graduationYear ?? ''),
              _buildInfoItem('Dân tộc học sinh', student.ethnicity ?? ''),
              _buildInfoItem('Tôn giáo học sinh', student.religion ?? ''),
              _buildInfoItem('Đối tượng học sinh (khu vực nào)', student.beneficiary ?? ''),
              _buildInfoItem('Khu vực', student.area ?? ''),
              _buildInfoItem('Ngày cấp cmnd', formCardIssuedDate),
              _buildInfoItem('Nơi cấp cmnd', student.idCardIssuedPlace ?? ''),
              _buildInfoItem('Họ tên Cha', student.fatherFullName ?? ''),
              _buildInfoItem('Họ tên Mẹ', student.motherFullName ?? ''),
              _buildInfoItem('Ghi chú', student.notes ?? ''),
              _buildInfoItem('Tình trạng học sinh', isStudying ? 'Học sinh đang học' : 'Học sinh đã nghỉ học'),
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
