import 'package:melakago_web/Model/reward.dart';
import 'package:melakago_web/Model/tourismService.dart';

import '../Controller/request_controller.dart';
import 'appUser.dart';

class redeemReward {
  int? redeemId;
  int? rewardId;
  int? appUserId;
  String? claimCode;
  int? pointsRedeemed;
  String? dateRedeemed;
  String? expirationDate;
  int? status;
  appUser? user;
  Reward? reward;
  int? tourismServiceId;

  redeemReward(
      this.redeemId,
      this.rewardId,
      this.appUserId,
      this.claimCode,
      this.pointsRedeemed,
      this.dateRedeemed,
      this.expirationDate,
      this.status,
      this.user,
      this.reward,
      this.tourismServiceId,
      );

  redeemReward.getRedeemId(
      this.appUserId,
      this.rewardId,
      );

  redeemReward.searchByTSID(
      this.tourismServiceId,
      );

  redeemReward.updateRedeemReward(
      this.redeemId,
      this.appUserId,
      this.rewardId,
      );

  redeemReward.fromJson(Map<String, dynamic> json)
      : redeemId = json['redeemId'] as dynamic?,
        rewardId = json['rewardId'] as dynamic?,
        appUserId = json['appUserId'] as dynamic?,
        claimCode = json['claimCode'] as String? ?? '',
        pointsRedeemed = json['pointsRedeemed'] as dynamic?,
        dateRedeemed = json['dateRedeemed'] as dynamic?,
        expirationDate = json['expirationDate'] as String? ?? '',
        status = json['status'] as dynamic?,
        reward = Reward.newJ(
          json['rewardName'] as String? ?? '',
          json['rewardCode'] as String? ?? '',
        ),
        user = appUser.newJ(
          json['firstName'] as String? ?? '',
          json['lastName'] as String? ?? '',
        );

  Map<String, dynamic> toJson() => {
    'redeemId': redeemId,
    'rewardId': rewardId,
    'appUserId': appUserId,
    'claimCode':claimCode,
    'pointsRedeemed': pointsRedeemed,
    'dateRedeemed': dateRedeemed,
    'expirationDate': expirationDate,
    'status': status,
    'reward':reward,
    'user':user,
    'tourismServiceId':tourismServiceId,
  };


  Future<bool> getRedeemRewardId() async {
    RequestController req = RequestController(path: "/api/company/getRedeemRewardId.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      redeemId=req.result()['redeemId'];
      print(redeemId);
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> updateStatus() async {

    RequestController req = RequestController(path: "/api/company/getRedeemRewardId.php");
    req.setBody(toJson());
    await req.put();
    if (req.status() == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<redeemReward>> loadRewardRedeem() async {
    List<redeemReward> result = [];
    RequestController req =
    RequestController(path: "/api/company/getListUserClaim.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(redeemReward.fromJson(item));
      }
    }
    return result;
  }
}