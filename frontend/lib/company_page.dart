import 'package:escort/component/header_component.dart';
import 'package:flutter/material.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: companyList(),
      ),
    );
  }

  Widget companyList() {
    return Column(
      children: [
        buildHeader("Company", icon: Icons.assistant_photo),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 24, top: 16, right: 16),
            child: Column(
              children: [
                Image.asset("assets/banner.png"),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        companyItem(),
                        companyItem(),
                        companyItem(),
                        companyItem(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget companyItem() {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 20, 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 4,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://haeyum.dev/pangmoo/profile.jpeg'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Flexible(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'WOW',
                        style: TextStyle(
                            color: Color(0xFF3B3B3B),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Sun Bright Light Residence 2972 Westheimer Rd. Illinois 85486 ',
                        style: TextStyle(
                          color: Color(0xFF3B3B3B),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
