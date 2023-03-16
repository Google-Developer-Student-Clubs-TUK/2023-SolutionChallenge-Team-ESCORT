import 'package:get/get.dart';

class RegistrationController extends GetxController {
  var registrationList = Rx(<dynamic>[]);

  RegistrationController() {
    _loadData();
  }

  void _loadData() {
    GetConnect()
        .get(
            'http://34.22.70.120:8080/api/v1/ppConnection/protector/1MyLeAmcVjRpy6FxOwj9YKaG2du1')
        .then(
          (value) => {registrationList.value = value.body['result']},
        );
  }
}
