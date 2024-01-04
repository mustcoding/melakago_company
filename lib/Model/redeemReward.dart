import '../Controller/request_controller.dart';

class redeemReward {
  int? redeemId;
  int? rewardId;
  int? appUserId;
  int? pointsRedeemed;
  String? dateRedeemed;
  String? expirationDate;
  int? status;

  redeemReward(
      this.redeemId,
      this.rewardId,
      this.appUserId,
      this.pointsRedeemed,
      this.dateRedeemed,
      this.expirationDate,
      this.status,
      );

  redeemReward.getRedeemId(
      this.appUserId,
      this.rewardId,
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
        pointsRedeemed = json['pointsRedeemed'] as dynamic?,
        dateRedeemed = json['dateRedeemed'] as dynamic?,
        expirationDate = json['expirationDate'] as String? ?? '',
        status = json['status'] as dynamic?;

  Map<String, dynamic> toJson() => {
    'redeemId': redeemId,
    'rewardId': rewardId,
    'appUserId': appUserId,
    'pointsRedeemed': pointsRedeemed,
    'dateRedeemed': dateRedeemed,
    'expirationDate': expirationDate,
    'status': status,
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
}