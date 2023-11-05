import 'dart:math';

abstract class BaseMockData {
  List<DateTime> generateRandomTimeRange() {
    final random = Random();

    final now = DateTime.now();
    final hourStart = random.nextInt(24); // 0-23 giờ
    final minuteStart = random.nextInt(60); // 0-59 phút
    final secondStart = random.nextInt(60); // 0-59 giây

    final hourEnd = hourStart + random.nextInt(24 - hourStart); // Thời gian kết thúc sau thời gian bắt đầu
    final minuteEnd = random.nextInt(60); // 0-59 phút
    final secondEnd = random.nextInt(60); // 0-59 giây

    final randomStartTime = DateTime(now.year, now.month, now.day, hourStart, minuteStart, secondStart);
    final randomEndTime = DateTime(now.year, now.month, now.day, hourEnd, minuteEnd, secondEnd);

    return [randomStartTime, randomEndTime];
  }

  DateTime generateRandomTime() {
    final random = Random();

    final now = DateTime.now();
    final hourStart = random.nextInt(24); // 0-23 giờ
    final minuteStart = random.nextInt(60); // 0-59 phút
    final secondStart = random.nextInt(60); // 0-59 giây

    return DateTime(now.year, now.month, now.day, hourStart, minuteStart, secondStart);
  }

  DateTime generateRandomDayOfMonth(DateTime now) {
    final random = Random();
    int days = DateTime(now.year, now.month + 1, 0).day;

    final day = random.nextInt(days);
    final hourStart = random.nextInt(24); // 0-23 giờ
    final minuteStart = random.nextInt(60); // 0-59 phút
    final secondStart = random.nextInt(60); // 0-59 giây

    return DateTime(now.year, now.month, day, hourStart, minuteStart, secondStart);
  }

  String generateRandomType(List<String> listData) {
    final random = Random();
    final index = random.nextInt(listData.length);
    return listData[index];
  }

  String generateName() {
    final random = Random();
    final names = ['manh', 'le', 'van'];
    final index = random.nextInt(names.length);
    return names[index];
  }

  String generateMajor() {
    final random = Random();
    final names = [
      'Toán',
      'Hóa',
      'Sinh',
      'TA',
      'Ngoại ngữ trung',
      'Lâp trinh',
      'Game',
      'Chơi game',
    ];
    final index = random.nextInt(names.length);
    return names[index];
  }

  String generateType() {
    final random = Random();
    final names = [
      'available',
      'off',
      'cancel',
    ];
    final index = random.nextInt(names.length);
    return names[index];
  }

  // String generateRole() {
  //   final random = Random();
  //   final roles = ['MG', 'SM', 'SS'];
  //   final index = random.nextInt(roles.length);
  //   return roles[index];
  // }
}
