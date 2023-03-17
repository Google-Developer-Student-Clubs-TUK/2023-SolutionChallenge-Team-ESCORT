import 'package:escort/dementia.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DementiaController extends GetxController {
  RxBool isShowCall = false.obs;
  Rx<DementiaInfo?> dmentiaInfo = Rx<DementiaInfo?>(null);

  void clickCall(String phone) {
    isShowCall.value = !isShowCall.value;

    if (!isShowCall.value) {
      launchUrl(Uri.parse('tel:$phone'));
    }
  }

  void loadDetail(String uid) async {
    var response = await GetConnect()
        .get('http://34.22.70.120:8080/api/v1/protege/$uid')
        .then((value) => value.body['result']);

    dmentiaInfo.value = DementiaInfo(
      image: response['imageUrl'],
      name: response['name'],
      phone: response['phone'],
      characteristics: response['characteristics'],
      safeZone: response['safeZones'],
      regidence: response['regidence'],
      bloodType: response['bloodType'],
    );
  }
}
