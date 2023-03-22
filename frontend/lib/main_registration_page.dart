import 'dart:developer';
import 'dart:ui';

import 'package:escort/main_dementia_controller.dart';
import 'package:escort/registration_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                              registrationController
                                  .registrationList.value[index]['age']
                                  .toString(),
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
              Get.to(QRViewExample(registerController: registrationController,));
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
                    buildKeyValueInfo('Age', '$age years old'),
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
                      dementiaController.isSafe.value,
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
  // const QRViewExample({Key? key}) : super(key: key);

  RegistrationController registerController;
  QRViewExample({required this.registerController});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState(registerController: registerController);
}

class _QRViewExampleState extends State<QRViewExample> {
  RegistrationController registerController;
  _QRViewExampleState({required this.registerController});

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
    controller.scannedDataStream.listen(
      (scanData) {
        setState(
          () {
            result = scanData;
            String? code = result?.code;

            controller.stopCamera();

            if (code != null) {
              _requestPostRegisterDementia(
                code,
                (onResult) {
                  if (onResult) {
                    resultDialog(
                      Icons.check_box,
                      'Scan Successful!',
                      'The old man has been registered on the registration list.',
                      'Go to Home',
                      () {
                        Navigator.pop(context);
                        Get.back();
                        registerController.loadData();
                      },
                    );
                  } else {
                    resultDialog(
                      Icons.error,
                      'Scan Failure!',
                      'Invalid qr code or network error.',
                      'Try again',
                      () {
                        Navigator.pop(context);
                        controller.resumeCamera();
                      },
                    );
                  }
                },
              );
            } else {
              resultDialog(
                Icons.error,
                'Scan Failure!',
                'Invalid qr code.',
                'Try again',
                () {
                  Navigator.pop(context);
                  controller.resumeCamera();
                },
              );
            }
          },
        );
      },
    );
  }

  void resultDialog(
    IconData icon,
    String title,
    String content,
    String buttonText,
    GestureTapCallback onClick,
  ) {
    Get.dialog(
      Expanded(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Wrap(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 42, 16, 32),
                        child: Column(
                          children: [
                            Container(
                              width: 112,
                              height: 112,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: const [
                                    Color(0xCC10403B),
                                    Color(0xFF10403B)
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  icon,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              title,
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 18),
                            Text(
                              content,
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 56,
                            ),
                            Material(
                              child: InkWell(
                                onTap: onClick,
                                borderRadius: BorderRadius.circular(100),
                                child: Ink(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF10403B),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      buttonText,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void _requestPostRegisterDementia(String code, void Function(bool) onResult) {
    GetConnect()
        .post(
            'http://34.22.70.120:8080/api/v1/ppConnection',
            'protectorUId=${FirebaseAuth.instance.currentUser?.uid ?? "-"}&protegeUId=$code',
            contentType: 'application/x-www-form-urlencoded',
            headers: {"Accept": "application/json"})
        .then(
      (value) {
        onResult(value.body['code'] == 'PP000');
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
