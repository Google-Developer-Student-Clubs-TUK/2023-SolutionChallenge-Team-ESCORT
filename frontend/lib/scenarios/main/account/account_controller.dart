import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../dementia/dementia.dart';

class AccountController extends GetxController {
  AccountController() {
    GetConnect()
        .get(
            'http://34.22.70.120:8080/api/v1/protector/${FirebaseAuth.instance.currentUser?.uid ?? "-"}')
        .then(
          (value) {
            partnerInfo.value = PartnerInfo(
              image: value.body['result']['imageUrl'],
              name: value.body['result']['name'],
              phone: value.body['result']['phone'],
            );
          }
        );
  }

  Rx<PartnerInfo?> partnerInfo = Rx<PartnerInfo?>(null);
}
