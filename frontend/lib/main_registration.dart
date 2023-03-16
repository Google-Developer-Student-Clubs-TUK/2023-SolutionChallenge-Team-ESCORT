import 'dart:developer';

import 'package:escort/RegistrationController.dart';
import 'package:escort/component/header_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegistrationController registrationController =
        Get.put(RegistrationController());

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            buildHeader(
              "Registration",
              icon: Icons.elderly,
              onClickNotification: () {},
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount:
                        registrationController.registrationList.value.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          buildRegistration(
                            registrationController.registrationList.value[index]
                                ['imageUrl'],
                            registrationController.registrationList.value[index]
                                ['name'],
                            "72",
                            registrationController.registrationList.value[index]
                                ['safeZones'][0],
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
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const QRViewExample(),
              ));
            },
            backgroundColor: Colors.blueAccent,
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                "assets/floatbutton.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell buildRegistration(
      String image, String name, String age, String safeZone) {
    return InkWell(
      onTap: (){ },
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
                        image: NetworkImage(image),
                      ),
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
                child: Container(
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
      body: Column(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(119, 119, 119, 23),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 400, top: 20),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
                Text(
                  "Scan QR Code",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "Please scan the old man's QR code.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  "Register the elderly to the registration list.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(height: 450, child: _buildQrView(context)),
          Container(
            height: 70,
            color: Color.fromRGBO(119, 119, 119, 23),
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
