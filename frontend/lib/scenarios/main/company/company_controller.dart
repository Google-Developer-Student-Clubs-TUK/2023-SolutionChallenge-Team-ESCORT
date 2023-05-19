import 'package:get/get.dart';

class CompanyController extends GetxController {
  CompanyController() {
    GetConnect().get('http://34.22.87.100:8080/api/v1/company').then(
      (value) {
        var response = value.body['result'];
        List<CompanyInfo> tempCompanyList = [];

        response.forEach(
          (element) {
            tempCompanyList.add(
              CompanyInfo(
                id: element['id'],
                title: element['title'],
                address: element['address'],
                description: element['description'],
                images: List.castFrom(element['images']),
              ),
            );
          },
        );

        companyList.value = tempCompanyList;
      },
    );
  }

  RxList<CompanyInfo> companyList = RxList<CompanyInfo>();
  var isShowDetail = false.obs;
  Rx<CompanyInfo?> companyInfo = Rx(null);

  void showDetail(CompanyInfo companyInfo) {
    this.companyInfo.value = companyInfo;
    isShowDetail.value = true;
  }

  void hideDetail() {
    isShowDetail.value = false;
  }
}

class CompanyInfo {
  CompanyInfo(
      {required this.id,
      required this.title,
      required this.address,
      required this.description,
      required this.images});

  int id;
  String title, address, description;
  List<String> images = [];
}
