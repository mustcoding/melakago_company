import 'package:melakago_web/Model/reward.dart';

import '../Controller/request_controller.dart';
import 'appUser.dart';

class companyReward {
  int? crId;
  int? rewardId;
  int? appUserId;
  int? tourismServiceId;
  String? dateRedeem;
  int? pointRedeem;
  Reward? reward;
  appUser? user;


  companyReward(
      this.crId,
      this.rewardId,
      this.appUserId,
      this.tourismServiceId,
      this.dateRedeem,
      this.pointRedeem,
      this.reward,
      this.user,
      );

  companyReward.Add(
      this.crId,
      this.rewardId,
      this.appUserId,
      this.tourismServiceId,
      this.dateRedeem,
      this.pointRedeem,
      );

  companyReward.getList(
      this.tourismServiceId,
      );

  // Existing code...

  companyReward.fromJson(Map<String, dynamic> json)
      : crId = json['crId'] as dynamic?,
        rewardId = json['rewardId'] as dynamic?,
        appUserId = json['appUserId'] as dynamic?,
        tourismServiceId = json['tourismServiceId'] as dynamic?,
        dateRedeem = json['dateRedeem'] as String? ?? '',
        pointRedeem = json['pointRedeem'] as dynamic?,
        reward = Reward.newJ(
          json['rewardName'] as String? ?? '',
          json['rewardCode'] as String? ?? '',
        ),
        user = appUser.newJ(
          json['firstName'] as String? ?? '',
          json['lastName'] as String? ?? '',
        );
  // Initialize it from JSON


  //toJson will be automatically called by jsonEncode when necessary
  Map<String, dynamic> toJson() => {
    'crId': crId,
    'rewardId': rewardId,
    'appUserId': appUserId,
    'tourismServiceId': tourismServiceId,
    'dateRedeem': dateRedeem,
    'pointRedeem': pointRedeem,
    'reward':reward,
    'user':user,
  };

  Future<bool> saveRedeemByCompany() async {
    RequestController req = RequestController(path: "/api/company/redeemCompany.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200)
    {
      return true;
    }
    else {
      return false;
    }
  }

  Future<List<companyReward>> loadCompanyRedeem() async {
    List<companyReward> result = [];
    RequestController req =
    RequestController(path: "/api/company/getCompanyRedeemed.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(companyReward.fromJson(item));
      }
    }
    return result;
  }

// Existing code...
}