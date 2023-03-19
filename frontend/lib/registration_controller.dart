import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dementia.dart';

class RegistrationController extends GetxController {
  var screenState = RegistrationScreenState.list().obs;

  var registrationList = Rx(<dynamic>[]);
  var isDetail = false.obs;
  var uid = "".obs;

  RxBool isShowCall = false.obs;
  Rx<DementiaInfo?> dmentiaInfo = Rx<DementiaInfo?>(null);

  RegistrationController() {
    _loadData();
  }

  void _loadData() {
    GetConnect()
        .get(
            'http://34.22.70.120:8080/api/v1/ppConnection/protector/${FirebaseAuth.instance.currentUser!.uid}')
        .then(
          (value) => {registrationList.value = value.body['result']},
        );

    registrationList.listen((p0) {
      print("WOW");
      print(p0);
    });
  }

  void showDetail(String uid) {
    this.uid.value = uid;
    isDetail.value = true;
    print("showDetail: ${isDetail.value}");
    print("uid.value: ${this.uid.value}");
  }

  void hideDetail() => isDetail.value = false;

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

    print(response);
    dmentiaInfo.value = DementiaInfo(
      image: response['imageUrl'],
      name: response['name'],
      phone: response['phone'],
      characteristics: response['characteristic'],
      safeZone: response['safeZones'][0],
      bloodType: response['bloodType'],
    );
  }
}

class RegistrationScreenState {
  RegistrationScreenState._();

  factory RegistrationScreenState.list() = RegistrationListScreenState;
  factory RegistrationScreenState.detail(String uid) = RegistrationDetailScreenState;
}

class RegistrationListScreenState extends RegistrationScreenState {
  RegistrationListScreenState() : super._();
}

class RegistrationDetailScreenState extends RegistrationScreenState {
  RegistrationDetailScreenState(this.uid) : super._();

  final String uid;
}
