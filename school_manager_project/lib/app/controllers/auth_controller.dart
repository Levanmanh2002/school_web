import 'package:get/get.dart';

class AuthController extends GetxController {
  RxString token = ''.obs;

  void setToken(String newToken) {
    token.value = newToken;
  }
}
