// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

void confirmLogout(BuildContext context, dynamic logout) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Xác nhận đăng xuất', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
        content: const Text(
          'Bạn có chắc chắn muốn đăng xuất?',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Hủy', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'Xác nhận',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.red),
            ),
            onPressed: () async {
              await logout();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
