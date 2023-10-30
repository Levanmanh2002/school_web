import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextWidgets extends StatelessWidget {
  const CustomTextWidgets({
    super.key,
    this.controller,
    required this.isEditing,
    required this.title,
    required this.initialData,
    this.color = Colors.black,
    this.keyboardType = TextInputType.text,
    this.validator = false,
    this.style,
  });

  final String title;
  final String? initialData;
  final Color color;
  final TextEditingController? controller;
  final RxBool isEditing;
  final TextInputType keyboardType;
  final bool validator;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(alignment: Alignment.topLeft, child: Text(title, style: style)),
        Obx(
          () => Container(
            child: isEditing.value
                ? TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: initialData,
                      errorStyle: const TextStyle(color: Colors.red),
                      labelStyle: TextStyle(color: color),
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
                      // suffixIcon: controller!.value.text.isNotEmpty
                      //     ? InkWell(
                      //         onTap: () {
                      //           controller!.clear();
                      //         },
                      //         child: const Icon(Icons.clear))
                      //     : null,
                    ),
                    keyboardType: keyboardType,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: color),
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
                  )
                : TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: initialData,
                      errorStyle: TextStyle(color: color),
                      labelStyle: TextStyle(color: color),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: color),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: color),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: color),
                  ),
          ),
        ),
      ],
    );
  }
}
