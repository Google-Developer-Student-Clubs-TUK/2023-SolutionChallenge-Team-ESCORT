import 'package:escort/web/feature_screen.dart';
import 'package:escort/web/title_screen.dart';
import 'package:flutter/material.dart';

class WebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final featureGlobalKey = GlobalKey();
    double mediaQuery = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Color(0xFFF2F2F2),
        child: SingleChildScrollView(
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
            ],
          ),
        ),
      ),
    );
  }
}
