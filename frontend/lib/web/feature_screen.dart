import 'package:escort/web/hover_animation.dart';
import 'package:flutter/material.dart';

// 0xFF347E5B

Widget buildFeatureScreen(GlobalKey globalKey, double mediaQuery) => Container(
      key: globalKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(60, 200, 60, 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildFeature(
                    1,
                    'Simple registration',
                    'Enroll seniors by scanning a QR code',
                    crossAxisAlignment: CrossAxisAlignment.end,
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(height: 90),
                  _buildFeature(
                    3,
                    'Partners Company',
                    'Patients and caregivers can be supported by partners company.',
                    crossAxisAlignment: CrossAxisAlignment.end,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 200),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0x1E347E5B),
                    ),
                    width: mediaQuery * 0.3,
                    height: mediaQuery * 0.3,
                  ),
                  HoverAnimation(
                    x: mediaQuery * -0.12,
                    y: -100,
                    shakeHeight: 40,
                    child: Image(
                      image: AssetImage('assets/iphone_feat2.png'),
                      width: mediaQuery * 0.165, // 0.1155,
                      height: mediaQuery * 0.33, // 0.0231,
                    ),
                  ),
                  HoverAnimation(
                    x: mediaQuery * 0.12,
                    y: 0,
                    shakeHeight: -60,
                    child: Image(
                      image: AssetImage('assets/iphone_feat1.png'),
                      width: mediaQuery * 0.165, // 0.1155,
                      height: mediaQuery * 0.33, // 0.0231,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeature(
                    2,
                    'Real-time patient location',
                    'Know your patient\'s location in real time.',
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 90),
                  _buildFeature(
                    4,
                    'Privacy and security',
                    'We care about privacy and security.',
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget _buildNumber(int number) => Container(
// width: 40,
// height: 40,
      decoration: BoxDecoration(
        color: Color(0xFF347E5B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Text(
          number.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget _buildFeature(int number, String title, String description,
        {required CrossAxisAlignment crossAxisAlignment,
        required TextAlign textAlign}) =>
    Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        _buildNumber(number),
        SizedBox(height: 18),
        Text(
          title,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          textAlign: textAlign,
        ),
        SizedBox(height: 18),
        Text(
          description,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          textAlign: textAlign,
        ),
      ],
    );
