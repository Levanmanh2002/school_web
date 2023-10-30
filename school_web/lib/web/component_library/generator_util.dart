import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

class GeneratorUtils {
  static Future<File?> takePictureFromUrl(String url, {double pixelRatio = 3}) async {
    try {
      // Download the image
      final response = await http.get(Uri.parse(url));
      final uint8list = response.bodyBytes;

      // Get the size of the image after downloading
      final sizeAfter = uint8list.length;

      // Print the sizes before and after
      print('Size before download: $sizeAfter bytes');

      final directory = (await getApplicationDocumentsDirectory()).path;
      final file = File('$directory/image.png');
      await file.writeAsBytes(uint8list);

      print('Size after download: ${file.lengthSync()} bytes');

      return file;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> saveNetworkImage(String path) async {
    await GallerySaver.saveImage(path);
  }
}
