import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DementiaInfo {
  String image,
      name,
      phone,
      characteristics,
      safeZone,
      regidence,
      bloodType;

  DementiaInfo({
    required this.image,
    required this.name,
    required this.phone,
    required this.characteristics,
    required this.safeZone,
    required this.regidence,
    required this.bloodType,
  });
}

class PartnerInfo {
  String image, name, phone, relationship;

  PartnerInfo({
    required this.image,
    required this.name,
    required this.phone,
    required this.relationship,
  });
}

SizedBox buildDementia(DementiaInfo dementiaInfo, PartnerInfo partnerInfo,
    RxBool isShowCall, GestureTapCallback onClickCall) {
  return SizedBox(
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
                              image: NetworkImage(dementiaInfo.image),
                            ),
                            shape: BoxShape.circle),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 16),
                        Text(
                          dementiaInfo.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          dementiaInfo.phone,
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
                  _buildInformation(
                    'Characteristics',
                    dementiaInfo.characteristics,
                  ),
                  _buildInformation(
                    'Safe Zone',
                    dementiaInfo.safeZone,
                  ),
                  _buildInformation(
                    'Regidence',
                    dementiaInfo.regidence,
                  ),
                  _buildInformation(
                    'Blood Type',
                    dementiaInfo.bloodType,
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
                onTap: onClickCall,
                child: Ink(
                  decoration: BoxDecoration(
                    color: Color(0xFFE8E9EB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Expanded(
                              child: FractionallySizedBox(
                                widthFactor: 0.385,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(partnerInfo.image),
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
                                  partnerInfo.name,
                                  style: TextStyle(
                                      color: Color(0xFF10403B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Relationship: ${partnerInfo.relationship}',
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
                            opacity: isShowCall.value ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xCC10403B),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
  );
}

Padding _buildInformation(String type, String description) {
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
