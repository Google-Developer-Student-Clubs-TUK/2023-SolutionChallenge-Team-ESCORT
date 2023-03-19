import 'package:escort/company_controller.dart';
import 'package:escort/component/header_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:get/get.dart';

class CompanyPage extends StatelessWidget {
  CompanyPage({Key? key}) : super(key: key);

  final CompanyController companyController = Get.put(CompanyController());

  @override
  Widget build(BuildContext context) {
    companyController.hideDetail();

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            if (!companyController.isShowDetail.value) {
              return companyList(
                companyController.companyList,
                (companyId) {
                  companyController.showDetail(companyId);
                },
              );
            } else {
              var companyInfo = companyController.companyInfo.value;

              if (companyInfo != null) {
                return companyDetail(
                  companyInfo,
                  companyController.hideDetail,
                );
              } else {
                return Text('Loading');
              }
            }
          },
        ),
      ),
    );
  }

  Widget companyList(
    List<CompanyInfo> companyList,
    void Function(CompanyInfo companyInfo) onClickItem,
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
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return companyItem(companyList[index], onClickItem);
                    },
                    itemCount: companyList.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget companyItem(
    CompanyInfo companyInfo,
    void Function(CompanyInfo companyInfo) onClickItem,
  ) {
    return InkWell(
      onTap: () {
        onClickItem(companyInfo);
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
                  aspectRatio: 1.1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(companyInfo.images[0]),
                        fit: BoxFit.fill,
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
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      companyInfo.title,
                      style: TextStyle(
                          color: Color(0xFF3B3B3B),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      companyInfo.description,
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

  Widget companyDetail(CompanyInfo companyInfo, void Function() onClickBack) {
    final bannerId = ConstraintId('banner');
    final companyInfoId = ConstraintId('companyInfo');
    final listViewId = ConstraintId('listView');

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
                companyInfo.images[0],
                fit: BoxFit.fitWidth,
              ).applyConstraintId(id: bannerId),
              detailCompanyInfoItem(companyInfo)
                  .applyConstraintId(id: companyInfoId),
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
                      Image.network(companyInfo.images[2]),
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

  Widget detailCompanyInfoItem(CompanyInfo companyInfo) {
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
                      image: NetworkImage(companyInfo.images[1]),
                      fit: BoxFit.fill,
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
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    companyInfo.title,
                    style: TextStyle(
                        color: Color(0xFF3B3B3B),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    companyInfo.description,
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
