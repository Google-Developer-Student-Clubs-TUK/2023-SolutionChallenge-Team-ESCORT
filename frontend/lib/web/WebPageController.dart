import 'package:get/get.dart';

class WebPageController extends GetxController {
  final isShowCustomerSubmitAlert = false.obs;
  final isShowCompanySubmitAlert = false.obs;

  void showCustomerSubmitAlert() {
    isShowCustomerSubmitAlert.value = true;
  }

  void hideCustomerSubmitAlert() {
    isShowCustomerSubmitAlert.value = false;
  }

  void showCompanySubmitAlert() {
    isShowCompanySubmitAlert.value = true;
  }

  void hideCompanySubmitAlert() {
    isShowCompanySubmitAlert.value = false;
  }
}