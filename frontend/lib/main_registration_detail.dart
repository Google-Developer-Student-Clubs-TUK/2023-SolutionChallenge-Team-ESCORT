import 'package:escort/dementia.dart';
import 'package:escort/main_dementia_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegistrationDetail extends StatelessWidget {
  const RegistrationDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DementiaController dementiaController = Get.put(DementiaController());

    dementiaController.loadDetail(Get.arguments[0]);

    final PartnerInfo partnerInfo = PartnerInfo(
      image:
          'https://tistory1.daumcdn.net/tistory/2743554/attach/cb196de69425482b93b43ad7fc207bf6',
      name: 'GwangMoo You',
      phone: '+82-10-6348-1143',
      relationship: 'Son',
    );

    return Obx(() {
      var demntiaInfo = dementiaController.dmentiaInfo.value;
      if (demntiaInfo != null) {
        return buildDementia(
          demntiaInfo,
          partnerInfo,
          dementiaController.isShowCall,
          () {
            dementiaController.clickCall(partnerInfo.phone);
          },
        );
      } else {
        return Text('Loading...');
      }
    });
  }
}
