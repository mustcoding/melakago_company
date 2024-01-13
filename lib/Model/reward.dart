import '../Controller/request_controller.dart';

class Reward {

  int? rewardId;
  String? rewardName;
  int? rewardPoint;
  String? rewardCode;
  String? tnc;
  int? tourismServiceId;

  Reward(
      this.rewardId,
      this.rewardName,
      this.rewardPoint,
      this.rewardCode,
      this.tnc,
      this.tourismServiceId,
      );

  Reward.newJ(
    this.rewardName,
    this.rewardCode,
  );

  Reward.getIdByCode(
      this.rewardCode,
      );

  Reward.tourismIdByCode(
      this.rewardCode,
      );

  Reward.fromJson(Map<String, dynamic> json)
      : rewardId = json['rewardId'] as dynamic?,
        rewardName = json['rewardName'] as String? ?? '',
        rewardPoint = json['rewardPoint'] as dynamic?,
        rewardCode = json['rewardCode'] as String? ?? '',
        tnc = json['tnc'] as String? ?? '',
        tourismServiceId = json['tourismServiceId'] as dynamic?;


  Map<String, dynamic> toJson() => {
    'rewardId': rewardId,
    'rewardName': rewardName,
    'rewardPoint': rewardPoint,
    'rewardCode': rewardCode,
    'tnc': tnc,
    'tourismServiceId':tourismServiceId,
  };

  Future<bool> getRewardId() async {
    RequestController req = RequestController(path: "/api/company/getRewardId.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      rewardId=req.result()['rewardId'];
      rewardPoint=req.result()['rewardPoint'];
      tourismServiceId = req.result()['tourismServiceId'];

      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> getTourismServiceId() async {
    RequestController req = RequestController(path: "/api/company/getRewardId.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      tourismServiceId=req.result()['tourismServiceId'];

      print(tourismServiceId);

      return true;
    }
    else {
      return false;
    }
  }
}