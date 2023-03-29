import 'package:escort/scenarios/main/account/account_controller.dart';
import 'package:escort/component/header_component.dart';
import 'package:escort/scenarios/dementia/dementia.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  final AccountController accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          PartnerInfo? partnerInfo = accountController.partnerInfo.value;

          if (partnerInfo != null) {
            return Column(
              children: [
                buildHeader("Account", icon: Icons.person),
                Padding(
                  padding: EdgeInsets.only(top: 28),
                ),
                FractionallySizedBox(
                  widthFactor: 0.55,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(partnerInfo.image),
                          fit: BoxFit.fill,
                        )),
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 18),
                ),
                Text(
                  partnerInfo.name,
                  style: TextStyle(
                      color: Color(0xFF808584),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    partnerInfo.phone,
                    style: TextStyle(
                        color: Color(0xFF808584),
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 34),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    children: [
                      buildNavigateButton(
                        Icons.person,
                        "Personal Information",
                        () {},
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                      ),
                      buildNavigateButton(
                        Icons.attach_email,
                        "Account Settings",
                        () {},
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 26),
                        child: Divider(thickness: 1, color: Color(0xFFE8E9EB)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Participate as an Company',
                          style: TextStyle(
                              color: Color(0xFF10403B),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Text('Loading...');
          }
        },
      ),
    );
  }

  InkWell buildNavigateButton(
      IconData icon, String text, GestureTapCallback? onTap) {
    return InkWell(
      onTap: onTap,
      customBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Ink(
        decoration: BoxDecoration(
            color: Color(0xFFEEF0F0), borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 18, 24, 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 24,
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Text(
                    text,
                    style: TextStyle(color: Color(0xFF808584), fontSize: 14),
                  ),
                ],
              ),
              Image.asset(
                "assets/arrow_next.png",
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
