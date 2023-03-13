import 'dart:convert';

import 'package:escort/userinfo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MainDementia extends StatelessWidget {
  final UserInfoController userinfoController = Get.put(UserInfoController());

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
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
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
                            children: const [
                              SizedBox(height: 16),
                              Text(
                                "GwangMoo You",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "+82 10 6348 1143",
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Characteristics",
                            style: TextStyle(
                              color: Color(0xFF10403B),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(child: Container()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '● A mole under the nose',
                                style: TextStyle(
                                    color: Color(0xFF10403B), fontSize: 14),
                              ),
                              Text(
                                '● Big ears and small lips',
                                style: TextStyle(
                                    color: Color(0xFF10403B), fontSize: 14),
                              ),
                              Text(
                                '● Reacting to the name ‘Frank’',
                                style: TextStyle(
                                    color: Color(0xFF10403B), fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Expanded(
                  flex: 26,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFE8E9EB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 7),
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
                            children: const [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Minsu Kim',
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
}
