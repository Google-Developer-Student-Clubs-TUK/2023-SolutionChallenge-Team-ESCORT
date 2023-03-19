import 'dart:developer';

import 'package:escort/main_dementia_controller.dart';
import 'package:escort/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'component/header_component.dart';
import 'dementia.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegistrationController registrationController =
        Get.put(RegistrationController());

    final DementiaController dementiaController = Get.put(DementiaController());
    registrationController.hideDetail();

    return Scaffold(
      body: Obx(
        () {
          if (registrationController.isDetail.value) {
            return _registrationDetailScreen(
                dementiaController,
                registrationController.uid.value,
                registrationController.hideDetail);
          } else {
            return _registrationListScreen(context, registrationController);
          }
        },
      ),
    );
  }

  Widget _registrationListScreen(
      BuildContext context, RegistrationController registrationController) {
    return Scaffold(
      body: Obx(
        () {
          return Column(
            children: [
              buildHeader(
                "Registration",
                icon: Icons.elderly,
                onClickNotification: () {},
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: SizedBox(
                    child: ListView.builder(
                      itemCount:
                          registrationController.registrationList.value.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            buildRegistration(
                              registrationController
                                  .registrationList.value[index]['imageUrl'],
                              registrationController
                                  .registrationList.value[index]['name'],
                              "72",
                              registrationController.registrationList
                                  .value[index]['safeZones'][0],
                              () {
                                registrationController.showDetail(
                                  registrationController
                                      .registrationList.value[index]['uid'],
                                );
                              },
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: FloatingActionButton(
            onPressed: () {
              Get.to(const QRViewExample());
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Image.asset(
              "assets/floatbutton.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  InkWell buildRegistration(String image, String name, String age,
      String safeZone, GestureTapCallback onClick) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          color: Color(0x1410403B),
          border: Border.all(
            color: Color(0xFF10403B),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 4,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: Color(0xFF10403B),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    buildKeyValueInfo('Age', '72 years old'),
                    buildKeyValueInfo('Safe Zone', safeZone),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildKeyValueInfo(String key, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$key: ",
          style: TextStyle(
              color: Color(0xFF808584),
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  color: Color(0xFF808584),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              overflow: TextOverflow.clip),
        ),
      ],
    );
  }

  Widget _registrationDetailScreen(DementiaController dementiaController,
      String uid, GestureTapCallback onClickBack) {
    dementiaController.loadDetail(uid);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(
              "Profile",
              enabledBack: true,
              onClickBack: onClickBack,
            ),
            Expanded(
              child: Obx(
                () {
                  var demntiaInfo = dementiaController.dementiainfo.value;
                  var partnerInfo = dementiaController.partnerInfo.value;
                  if (demntiaInfo != null && partnerInfo != null) {
                    return buildDementia(
                      demntiaInfo,
                      partnerInfo,
                      dementiaController.isShowCall,
                      () {
                        dementiaController.clickCall(partnerInfo.phone);
                      },
                    );
                  } else {
                    return Text('Loading...');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();

    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(context),
          // Container(
          //   alignment: Alignment.center,
          //   color: Color(0x88000000),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     child: Grid,
          //   ),
          // ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: Get.back,
                        child: Icon(
                          Icons.clear,
                          size: 24,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Scan QR Code",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      "Please scan the old man's QR code.",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Text(
                    "Register the elderly to the registration list.",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 500 ||
            MediaQuery.of(context).size.height < 500)
        ? 300.0
        : 450.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Color.fromRGBO(16, 64, 59, 10),
            borderRadius: 10,
            borderLength: 45,
            borderWidth: 12,
            cutOutSize: scanArea),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
