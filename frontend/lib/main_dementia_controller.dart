import 'package:escort/dementia.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DementiaController extends GetxController {
  RxBool isShowCall = false.obs;
  Rx<DementiaInfo?> dementiainfo = Rx<DementiaInfo?>(null);
  Rx<PartnerInfo?> partnerInfo = Rx<PartnerInfo?>(null);

  void clickCall(String phone) {
    isShowCall.value = !isShowCall.value;

    if (!isShowCall.value) {
      launchUrl(Uri.parse('tel:$phone'));
    }
  }

  // dementia
  void loadDementia() async {
    var response = await GetConnect()
        .get('http://34.22.70.120:8080/api/v1/protege/${FirebaseAuth.instance.currentUser?.uid ?? "-"}')
        .then((value) => value.body['result']);

    dementiainfo.value = DementiaInfo(
      image: response['imageUrl'],
      name: response['name'],
      phone: response['phone'],
      characteristics: response['characteristic'],
      safeZone: response['safeZones'][0],
      bloodType: response['bloodType'],
    );
  }

  void loadPartner() {
    GetConnect()
        .get(
            'http://34.22.70.120:8080/api/v1/ppConnection/protege/${FirebaseAuth.instance.currentUser?.uid ?? "-"}')
        .asStream()
        .map(
      (event) {
        return event.body['result'][0];
      },
    ).listen(
      (event) {
        partnerInfo.value = PartnerInfo(
            image: event['imageUrl'],
            name: event['name'],
            phone: event['phone']);
      },
    );
  }

  // partner
  void loadDetail(String uid) async {
    isShowCall.value = false;

    var response = await GetConnect()
        .get('http://34.22.70.120:8080/api/v1/protege/$uid')
        .then((value) => value.body['result']);

    dementiainfo.value = DementiaInfo(
      image: response['imageUrl'],
      name: response['name'],
      phone: response['phone'],
      characteristics: response['characteristic'],
      safeZone: response['safeZones'][0],
      bloodType: response['bloodType'],
    );

    response = await GetConnect()
        .get(
            'http://34.22.70.120:8080/api/v1/protector/${FirebaseAuth.instance.currentUser?.uid ?? "-"}')
        .then((value) => value.body['result']);

    partnerInfo.value = PartnerInfo(
      image: response['imageUrl'],
      name: response['name'],
      phone: response['phone'],
    );
  }
}
