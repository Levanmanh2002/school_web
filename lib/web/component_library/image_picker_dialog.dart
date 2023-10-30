import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog {
  static final ImagePicker _picker = ImagePicker();

  static Future<List<String>> imgFromGallery({int? capacity, String message = ''}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        if (capacity != null) {
          await Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 3,
          );
        }
        return [pickedFile.path];
      }
    } catch (e) {
      print('Lỗi khi lấy hình ảnh từ thư viện: $e');
    }

    return [];
  }
}
