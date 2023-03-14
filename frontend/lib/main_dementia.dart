import 'dart:convert';

import 'package:escort/main_dementia_controller.dart';
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

    // QR 코드로 표시 할 데이터

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
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 4),
            child: Column(
              children: [
                Expanded(
                  flex: 51,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                        colors: const [
                          Color(0xFF347E5B),
                          Color(0xE6205C49),
                          Color(0xCC10403B),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 24, 32, 22),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://tistory1.daumcdn.net/tistory/2743554/attach/cb196de69425482b93b43ad7fc207bf6'),
                                  ),
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(height: 16),
                              Text(
                                data['name'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                data['phoneNumber'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Expanded(
                  flex: 20,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFE8E9EB),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: PageView(
                      children: [
                        buildInformation(
                          'Characteristics',
                          data['characteristics'],
                        ),
                        buildInformation(
                          'Safe Zone',
                          data['safezone'],
                        ),
                        buildInformation(
                          'Regidence',
                          data['regidence'],
                        ),
                        buildInformation(
                          'Blood Type',
                          data['blood'],
                        ),
                        buildInformation(
                          'Favorite Place',
                          data['place'],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Expanded(
                  flex: 26,
                  child: SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onTap: dementiaController.clickCall,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Color(0xFFE8E9EB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: FractionallySizedBox(
                                      widthFactor: 0.385,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://tistory1.daumcdn.net/tistory/2743554/attach/cb196de69425482b93b43ad7fc207bf6'),
                                            ),
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        data['regidence'],
                                        style: TextStyle(
                                            color: Color(0xFF10403B),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'Relationship: Son',
                                        style: TextStyle(
                                          color: Color(0xFF808584),
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Obx(
                              () {
                                return AnimatedOpacity(
                                  opacity: dementiaController.isShowCall.value
                                      ? 1.0
                                      : 0.0,
                                  duration: const Duration(milliseconds: 200),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xCC10403B),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.call_outlined,
                                          size: 80,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 26,
                                        ),
                                        Text(
                                          '+82-10-1234-5678',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Container(
                      width: 250,
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          QrImage(
                            data: _qrCodeData,
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                );
                // Add your onPressed code here!
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: SizedBox(
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

  Padding buildInformation(String type, String description) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type,
            style: TextStyle(
              color: Color(0xFF10403B),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "● $description",
                style: TextStyle(color: Color(0xFF10403B), fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
