import 'package:escort/web/feature_screen.dart';
import 'package:escort/web/title_screen.dart';
import 'package:flutter/material.dart';

class WebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Color(0xFFF2F2F2),
        child: ListView(
          children: [
            buildTitleScreen(mediaQuery),
            buildFeatureScreen(mediaQuery),
          ],
        ),
      ),
    );
  }
}
