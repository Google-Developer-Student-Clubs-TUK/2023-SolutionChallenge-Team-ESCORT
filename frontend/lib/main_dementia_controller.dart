import 'package:get/get.dart';

class DementiaController extends GetxController {
  RxBool isShowCall = false.obs;

  void clickCall() {
    isShowCall.value = !isShowCall.value;

    if (!isShowCall.value) {
      print("TODO: CALL");
    }
  }
}