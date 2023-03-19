import 'package:get/get.dart';

class CompanyController extends GetxController {
  var isShowDetail = false.obs;
  var companyId = ''.obs;

  void showDetail(String companyId) {
    this.companyId.value = companyId;
    isShowDetail.value = true;
  }

  void hideDetail() {
    isShowDetail.value = false;
  }
}