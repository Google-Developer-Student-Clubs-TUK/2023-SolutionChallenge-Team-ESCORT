import 'package:escort/web/banner.dart';
import 'package:escort/web/feature_screen.dart';
import 'package:escort/web/partner_company_screen.dart';
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
              buildBanner(
                mediaQuery,
                'You can join the wait-list now',
                'Are you a senior or caregiver interested in our service? Join our wait-list today. We\'ll invite you when the service launches.',
                buttonText: 'Join wait-list',
                onClick: () {},
              ),
              buildPartnerCompanyScreen(mediaQuery)
            ],
          ),
        ),
      ),
    );
  }
}
