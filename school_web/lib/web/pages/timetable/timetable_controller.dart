import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:school_web/web/models/timetable.dart';
import 'package:http/http.dart' as http;

class TimetableController extends GetxController {
  final currentWeek = Rx<DateTime>(DateTime.now());

  DateTime _getStartOfWeek() {
    var startOfWeek = currentWeek.value.subtract(Duration(days: currentWeek.value.weekday - 1));
    startOfWeek = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day, 0, 0, 0);
    return startOfWeek;
  }

  DateTime _getEndOfWeek() {
    var endOfWeek = currentWeek.value.add(Duration(days: 7 - currentWeek.value.weekday));
    endOfWeek = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);
    return endOfWeek;
  }

  TimetableController() {
    getTimeTable();
  }

  Future<List<Timetable>> getTimeTable() async {
    try {
      final token = await const FlutterSecureStorage().read(key: 'token');
      var startOfWeek = _getStartOfWeek();
      startOfWeek = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
      var endOfWeek = _getEndOfWeek();
      endOfWeek = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);

      final results = await http.get(
        Uri.parse(
            'https://backend-shool-project.onrender.com/timetable/get-duration?startTime=${startOfWeek.millisecondsSinceEpoch}&endTime=${endOfWeek.millisecondsSinceEpoch}'),
        headers: {'Content-Type': 'application/json', 'Authorization': '$token'},
      );
      print(results);
    } catch (e) {
      print(e);
    }
    return [];
  }
}
