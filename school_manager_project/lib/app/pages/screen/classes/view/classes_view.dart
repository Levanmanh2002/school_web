// import 'package:flutter/material.dart';
// import 'package:school_manager_project/app/models/classes.dart';

// class ClassesView extends StatelessWidget {
//   const ClassesView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Future<List<ClassInfoData>> _getClassInfo() async {

//     }

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         iconTheme: const IconThemeData(color: Colors.black),
//         title: const Text(
//           'Danh sách lớp học',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
//         ),
//       ),
//       body: FutureBuilder<List<ClassInfoData>>(
//         future: _getClassInfo(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('Không có học sinh nào đang học.'));
//           } else {
//             return Column(
//               children: [
//                 const SizedBox(height: 16),
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Danh sách học sinh đang học: ${snapshot.data?.length}',
//                     style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.green),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       final student = snapshot.data![index];
//                       return _buildStudentCard(student, context);
//                     },
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }
