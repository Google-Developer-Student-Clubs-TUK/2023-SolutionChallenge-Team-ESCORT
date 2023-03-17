import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  var registrationList = Rx(<dynamic>[]);

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
  }
}
