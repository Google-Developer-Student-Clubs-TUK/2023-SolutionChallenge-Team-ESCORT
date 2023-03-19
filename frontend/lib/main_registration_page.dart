import 'package:escort/main_dementia_controller.dart';
import 'package:escort/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Obx(() {
        if (registrationController.isDetail.value) {
          return _registrationDetailScreen(
              dementiaController,
              registrationController.uid.value,
              registrationController.hideDetail);
        } else {
          return _registrationListScreen(registrationController);
        }
      }),
    );
  }

  Widget _registrationListScreen(
      RegistrationController registrationController) {
    return Scaffold(
      body: Container(
        child: Obx(() {
          return Column(
            children: [
              buildHeader(
                "Registration",
                icon: Icons.elderly,
                onClickNotification: () {},
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: SizedBox(
                  height: 600,
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
                            () {
                              registrationController.showDetail(
                                  registrationController
                                      .registrationList.value[index]['uid']);
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
            ],
          );
        }),
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
                        image: NetworkImage(image),
                        fit: BoxFit.fill
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
                  var demntiaInfo = dementiaController.dmentiaInfo.value;
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
