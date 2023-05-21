import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MainDementiaQr extends StatelessWidget {
  MainDementiaQr({super.key});

  @override
  Widget build(BuildContext context) {
    final name = Get.arguments[0];
    final uid = Get.arguments[1];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Ink(
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.close,
                        color: Color(0xFF10403B),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'QR Code'.tr,
                    style: TextStyle(
                        color: Color(0xFF10403B),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          name,
                          style: TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      AspectRatio(
                        aspectRatio: 1,
                        child: QrImage(
                          data: uid,
                          version: QrVersions.auto,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Text(
                      'QR code'.tr,
                      style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Show Escorter and simply register with each other!'.tr,
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildToolButton(
                          Icons.share,
                          'Share'.tr,
                          () {
                            print("Share");
                          },
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        buildToolButton(
                          Icons.save_alt,
                          'Save'.tr,
                          () {
                            print("Save");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildToolButton(IconData icon, String text, GestureTapCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(0xFF10403B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          text,
          style: TextStyle(
              color: Color(0xFF10403B),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
