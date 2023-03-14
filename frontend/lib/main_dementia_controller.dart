import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class DementiaController extends GetxController {
  RxBool isShowCall = false.obs;

  void clickCall(String phone) {
    isShowCall.value = !isShowCall.value;

    if (!isShowCall.value) {
      launchUrl(Uri.parse('tel:$phone'));
    }
  }
}