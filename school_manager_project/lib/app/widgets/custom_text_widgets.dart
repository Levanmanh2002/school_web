import 'package:flutter/material.dart';

class CustomTextWidgets extends StatelessWidget {
  const CustomTextWidgets({
    super.key,
    this.controller,
    required this.title,
    this.initialData,
    this.color = Colors.black,
    this.keyboardType = TextInputType.text,
    this.validator = false,
    this.style = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF373A43)),
    this.enabled = true,
  });

  final String title;
  final String? initialData;
  final Color color;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool validator;
  final TextStyle? style;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(alignment: Alignment.topLeft, child: Text(title, style: style)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            isDense: true,
            hintText: enabled == false ? initialData : title,
            hintStyle: const TextStyle(color: Color(0xFFB6BBC3), fontSize: 14, fontWeight: FontWeight.w400),
            errorStyle: const TextStyle(color: Colors.red),
            labelStyle: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w400),
            border: const OutlineInputBorder(),
            prefix: const SizedBox(width: 12),
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD2D5DA)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD2D5DA)),
            ),
            // suffixIcon: controller!.value.text.isNotEmpty
            //     ? InkWell(
            //         onTap: () {
            //           controller!.clear();
            //         },
            //         child: const Icon(Icons.clear))
            //     : null,
          ),
          keyboardType: keyboardType,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: color),
          validator: (value) {
            if (validator != false) {
              if (value == null || value.isEmpty) {
                return 'Thông tin không được để trống';
              }
            } else {
              null;
            }

            return null;
          },
        ),
      ],
    );
  }
}
