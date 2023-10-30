import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_web/web/models/majors_models.dart';

class MajorsPages extends StatefulWidget {
  const MajorsPages({super.key});

  @override
  State<MajorsPages> createState() => _MajorsPagesState();
}

class _MajorsPagesState extends State<MajorsPages> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editDescriptionController = TextEditingController();

  Future<List<MajorsData>> fetchMajors() async {
    final response = await http.get(Uri.parse('https://backend-shool-project.onrender.com/admin/majors'));

    if (response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];

      List<MajorsData> majors = data.map((e) => MajorsData.fromJson(e)).toList();

      return majors;
    } else {
      print(response.reasonPhrase);
    }
    return [];
  }

  Future<dynamic> addMajors() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://backend-shool-project.onrender.com/admin/add-major'));
    request.body = json.encode({"name": nameController.text, "description": descriptionController.text});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      Get.snackbar(
        "Thành công",
        "Ngành học mới đã được thêm thành công!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      print(await response.stream.bytesToString());
    } else {
      Get.snackbar(
        "Thất bại",
        "Thêm mới ngành học thất bại!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(response.reasonPhrase);
    }
  }

  Future<void> onEditMajors(String id) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('PUT', Uri.parse('https://backend-shool-project.onrender.com/admin/edit-major/$id'));
    request.body = json.encode({"name": editNameController.text, "description": editDescriptionController.text});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      Get.snackbar(
        "Thành công",
        "Ngành học đã được chỉnh sửa!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      editNameController.clear();
      editDescriptionController.clear();
      print(await response.stream.bytesToString());
    } else if (response.statusCode == 400) {
      Get.snackbar(
        "Thất bại",
        "Ngành học đã tồn tại!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Thất bại",
        "Chỉnh sửa ngành học thất bại!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> onDeleteMajors(String id) async {
    var request =
        http.Request('DELETE', Uri.parse('https://backend-shool-project.onrender.com/admin/delete-major/$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      Get.snackbar(
        "Thành công",
        "Ngành học đã được xóa!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      print(await response.stream.bytesToString());
    } else {
      Get.snackbar(
        "Thất bại",
        "Lỗi xóa ngành học!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(response.reasonPhrase);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    editNameController.dispose();
    editDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Danh sách các ngành học',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _showAddMajorsConfirmationDialog(context, addMajors);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder<List<MajorsData>>(
        future: fetchMajors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final majors = snapshot.data![index];

                return ListTile(
                  title: Text(majors.name ?? ''),
                  leading: const Icon(Icons.school),
                  subtitle: Text(
                    majors.description ?? '',
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                    maxLines: 3,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      _showEditMajorsConfirmationDialog(context, majors, onEditMajors);
                    },
                    icon: const Icon(Icons.edit, size: 16),
                  ),
                  onTap: () async {
                    await Future.delayed(const Duration(seconds: 2), () {
                      _showDeleteMajorsConfirmationDialog(context, majors, onDeleteMajors);
                    });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  _showAddMajorsConfirmationDialog(BuildContext context, dynamic addMajors) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thêm ngành học mới', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Vui lòng nhập thông tin để thêm ngành học mới?',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Tên ngành học',
                    hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    errorStyle: TextStyle(color: Colors.red),
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tên ngành học không được để trống';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Mô tả ngành học',
                    hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    errorStyle: TextStyle(color: Colors.red),
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mô tả không được để trống';
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      width: MediaQuery.of(context).size.width / 3.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Text(
                        'Hủy',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        addMajors();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      width: MediaQuery.of(context).size.width / 3.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue,
                      ),
                      child: const Text(
                        'Xác nhận',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  _showEditMajorsConfirmationDialog(BuildContext context, MajorsData majorsData, dynamic addMajors) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              const Text('Chỉnh sửa thông tin ngành học', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Vui lòng nhập thông tin để chỉnh sửa ngành học?',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: editNameController,
                  decoration: InputDecoration(
                    hintText: majorsData.name,
                    hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    errorStyle: const TextStyle(color: Colors.red),
                    labelStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(),
                    errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tên ngành học không được để trống';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: editDescriptionController,
                  decoration: InputDecoration(
                    hintText: majorsData.description,
                    hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    errorStyle: const TextStyle(color: Colors.red),
                    labelStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(),
                    errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mô tả không được để trống';
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      width: MediaQuery.of(context).size.width / 3.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Text(
                        'Hủy',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        addMajors(majorsData.sId);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      width: MediaQuery.of(context).size.width / 3.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue,
                      ),
                      child: const Text(
                        'Xác nhận',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteMajorsConfirmationDialog(
      BuildContext context, MajorsData majorsData, dynamic onDeleteMajors) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Xác nhận xóa ngành học"),
          content: Text("Bạn có chắc chắn muốn xóa ngành học ${majorsData.name}?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Hủy", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                onDeleteMajors(majorsData.sId);
                Navigator.of(context).pop();
              },
              child: const Text("Xác nhận", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
