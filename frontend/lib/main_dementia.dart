import 'dart:convert';

import 'package:escort/dementia.dart';
import 'package:escort/main_dementia_controller.dart';
import 'package:escort/main_dementia_qr.dart';
import 'package:escort/userinfo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MainDementia extends StatelessWidget {
  final UserInfoController userinfoController = Get.put(UserInfoController());
  final DementiaController dementiaController = Get.put(DementiaController());

  MainDementia({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      'dementia': userinfoController.dementia.toString(),
      'email': userinfoController.email.toString(),
      'password': userinfoController.password.toString(),
      'name': userinfoController.name.toString(),
      'birth': userinfoController.birth.toString(),
      'phoneNumber': userinfoController.phoneNumber.toString(),
      'characteristics': userinfoController.characteristics.toString(),
      'blood': userinfoController.blood.toString(),
      'regidence': userinfoController.regidence.toString(),
      'place': userinfoController.place.toString(),
      'safezone': userinfoController.safezone.toString(),
    };

    String json = jsonEncode(data);
    var _qrCodeData = json;
    print(_qrCodeData);

    DementiaInfo dementiaInfo = DementiaInfo(
      image:
          'https://tistory1.daumcdn.net/tistory/2743554/attach/cb196de69425482b93b43ad7fc207bf6',
      name: data['name'],
      phone: data['phoneNumber'],
      characteristics: data['characteristics'],
      safeZone: data['safezone'],
      regidence: data['regidence'],
      bloodType: data['blood'],
      favoritePlace: data['place'],
    );

    PartnerInfo partnerInfo = PartnerInfo(
      image:
          'https://tistory1.daumcdn.net/tistory/2743554/attach/cb196de69425482b93b43ad7fc207bf6',
      name: 'GwangMoo You',
      phone: '+82-10-6348-1143',
      relationship: 'Son',
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(
                width: 220,
                height: 20,
                child: Text(
                  "Escort",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 47.0),
                child: IconButton(
                    onPressed: () => {}, icon: Icon(Icons.notifications)),
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          bottomOpacity: 0.0,
          titleSpacing: 20,
          leadingWidth: 20,
          centerTitle: false,
          leading: Transform.translate(
            offset: Offset(10, 0),
            child: Image.asset("assets/logo.png"),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        ),
        body: buildDementia(
          dementiaInfo,
          partnerInfo,
          dementiaController.isShowCall,
          () {
            dementiaController.clickCall();
          },
        ),
        floatingActionButton: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: FloatingActionButton(
              onPressed: () {
                Get.to(MainDementiaQr(), arguments: [dementiaInfo.name]);
                // Add your onPressed code here!
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: SizedBox(
                width: 52,
                height: 52,
                child: Image.asset(
                  "assets/floatbutton.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
