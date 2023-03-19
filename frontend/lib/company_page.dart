import 'package:escort/company_controller.dart';
import 'package:escort/component/header_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:get/get.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CompanyController companyController = Get.put(CompanyController());
    companyController.hideDetail();

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (!companyController.isShowDetail.value) {
            return companyList(
              companyController,
              (companyId) {
                companyController.showDetail(companyId);
              },
            );
          } else {
            return companyDetail(companyController.hideDetail);
          }
        }),
      ),
    );
  }

  Widget companyList(
    CompanyController companyController,
    void Function(String companyId) onClickItem,
  ) {
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
                        companyItem(onClickItem),
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

  Widget companyItem(void Function(String companyId) onClickItem) {
    return InkWell(
      onTap: () {
        onClickItem('1');
      },
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
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
                      borderRadius: BorderRadius.circular(8),
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
    );
  }

  Widget companyDetail(void Function() onClickBack) {
    final bannerId = ConstraintId('banner');
    final companyInfoId = ConstraintId('companyInfo');
    final listViewId = ConstraintId('listView');

    const image1 =
        'https://storage.googleapis.com/solution_escort/cafe1.jpeg0337f78d-2bb8-468a-a9bc-aa9f55fbb985';
    const image2 =
        'https://storage.googleapis.com/solution_escort/cafe3.jpeg2d1a5b96-0238-424e-acf0-290678d2eb7e';

    return Column(
      children: [
        buildHeader("Company", enabledBack: true, onClickBack: onClickBack),
        Expanded(
          child: ConstraintLayout(
            childConstraints: [
              Constraint(
                id: bannerId,
                width: matchConstraint,
                height: matchConstraint,
                widthPercent: 1,
                heightPercent: 0.48,
                centerTo: parent,
                horizontalBias: 0,
                verticalBias: 0,
              ),
              Constraint(
                id: companyInfoId,
                width: matchParent,
                height: 144,
                top: bannerId.bottom,
                margin: EdgeInsets.fromLTRB(15, -48, 20, 15),
              ),
              Constraint(
                  id: listViewId,
                  width: matchParent,
                  height: matchConstraint,
                  top: companyInfoId.bottom,
                  bottom: parent.bottom)
            ],
            children: [
              Image.network(
                image1,
                fit: BoxFit.fitWidth,
              ).applyConstraintId(id: bannerId),
              detailCompanyInfoItem().applyConstraintId(id: companyInfoId),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 26, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Partner Benefit',
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                          'Get a place to rest and coffee discounts for families with dementia!',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 16,
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      Image.network(image1),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ).applyConstraintId(id: listViewId),
            ],
          ),
        ),
      ],
    );
  }

  Widget detailCompanyInfoItem() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
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
                    borderRadius: BorderRadius.circular(8),
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
    );
  }
}
