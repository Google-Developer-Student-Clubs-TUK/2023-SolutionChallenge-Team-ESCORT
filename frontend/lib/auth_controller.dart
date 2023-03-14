import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class AuthController extends GetxController {
  var name = ''.obs;
  var birth = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var dementia = 'Dementia.yes'.obs;
  var characteristics = ''.obs;
  var blood = ''.obs;
  var regidence = ''.obs;
  var place = ''.obs;
  var safezone = ''.obs;
  var imagePath = ''.obs;

  void setDementia(String value) => dementia.value = value;
  void setName(String value) => name.value = value;
  void setBirth(String value) => birth.value = value;
  void setPhoneNumber(String value) => phoneNumber.value = value;
  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;
  void setCharacteristics(String value) => characteristics.value = value;
  void setBlood(String value) => blood.value = value;
  void setRegidence(String value) => regidence.value = value;
  void setPlace(String value) => place.value = value;
  void setSafezone(String value) => safezone.value = value;

  void checkvalues() => {
        print(name),
        print(birth),
        print(phoneNumber),
        print(email),
        print(password),
        print(dementia),
        print(characteristics),
        print(blood),
        print(regidence),
        print(place),
        print(safezone),
        print(imagePath),
      };

  Future<void> saveImage(File imageFile) async {
    var directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
      final path = directory.path;
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
    }
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = '${directory!.path}/$fileName.png';
    await imageFile.copy(path);
    imagePath.value = path;
  }

  Future<File> getImageFile() async {
    var directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
      final path = directory.path;
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
    }

    final fileName = imagePath.value.split('/').last;
    final path = '${directory!.path}/$fileName';
    return File(path);
  }
}
