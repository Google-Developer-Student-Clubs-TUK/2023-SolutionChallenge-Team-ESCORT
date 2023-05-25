import 'package:escort/web/banner.dart';
import 'package:escort/web/feature_screen.dart';
import 'package:escort/web/partner_company_screen.dart';
import 'package:escort/web/title_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'WebPageController.dart';

class WebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final featureGlobalKey = GlobalKey();
    double mediaQuery = MediaQuery.of(context).size.width;

    final controller = Get.put(WebPageController());

    return Scaffold(
      body: Container(
        color: Color(0xFFF2F2F2),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  buildTitleScreen(mediaQuery, () {
                    Scrollable.ensureVisible(
                      featureGlobalKey.currentContext!,
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.easeInOut,
                    );
                  }),
                  buildFeatureScreen(featureGlobalKey, mediaQuery),
                  buildBanner(
                    mediaQuery,
                    'You can join the wait-list now',
                    'Are you a senior or caregiver interested in our service? Join our wait-list today. We\'ll invite you when the service launches.',
                    buttonText: 'Join wait-list',
                    onClick: controller.showCustomerSubmitAlert,
                  ),
                  buildPartnerCompanyScreen(
                      mediaQuery, controller.showCompanySubmitAlert)
                ],
              ),
            ),
            ObxValue(
              (isShow) => Visibility(
                visible: isShow.isTrue,
                maintainAnimation: true,
                maintainState: true,
                child: AnimatedOpacity(
                  opacity: isShow.isTrue ? 1 : 0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  child: _buildCustomerSubmitAlert(
                      controller.hideCustomerSubmitAlert),
                ),
              ),
              controller.isShowCustomerSubmitAlert,
            ),
            ObxValue(
              (isShow) => Visibility(
                visible: isShow.isTrue,
                maintainAnimation: true,
                maintainState: true,
                child: AnimatedOpacity(
                  opacity: isShow.isTrue ? 1 : 0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  child: _buildCompanySubmitAlert(
                      controller.hideCompanySubmitAlert),
                ),
              ),
              controller.isShowCompanySubmitAlert,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerSubmitAlert(Function() onClose) => GestureDetector(
        onTap: onClose,
        child: Expanded(
          child: Container(
            color: Color(0x88000000),
            child: Center(
              child: AlertDialog(
                title: Text(
                  'Join wait-list',
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Wrap(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'We will invite you when the service launches.',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 30),
                        buildText('Name'),
                        SizedBox(height: 16),
                        buildTextField(),
                        SizedBox(height: 16),
                        buildText('Email'),
                        SizedBox(height: 16),
                        buildTextField(),
                        SizedBox(height: 16),
                        buildText('Message'),
                        SizedBox(height: 16),
                        buildTextField(maxLines: 5),
                      ],
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: FilledButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFF10403B)),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(vertical: 25),
                                ),
                              ),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

Widget _buildCompanySubmitAlert(Function() onClose) => GestureDetector(
      onTap: onClose,
      child: Expanded(
        child: Container(
          color: Color(0x88000000),
          child: Center(
            child: AlertDialog(
              title: Text(
                'Join partner company',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Wrap(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'We will contact you about the partner',
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 30),
                      buildText('Manager Name'),
                      SizedBox(height: 16),
                      buildTextField(),
                      SizedBox(height: 16),
                      buildText('Email'),
                      SizedBox(height: 16),
                      buildTextField(),
                      SizedBox(height: 16),
                      buildText('Company Name'),
                      SizedBox(height: 16),
                      buildTextField(),
                      SizedBox(height: 16),
                      buildText('Message'),
                      SizedBox(height: 16),
                      buildTextField(maxLines: 5),
                    ],
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: FilledButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF10403B)),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 25),
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

Text buildText(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Color(0xFF212121),
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextField buildTextField({int maxLines = 1}) {
  return TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(style: BorderStyle.none),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(style: BorderStyle.none),
        borderRadius: BorderRadius.circular(8),
      ),
      fillColor: Color(0xFFF5F5F5),
      filled: true,
    ),
    maxLines: maxLines,
  );
}
