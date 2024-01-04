

import '../Controller/request_controller.dart';

class appUser {
  int? appUserId;
  String? firstName;
  String? lastName;
  String? nickName;
  String? dateOfBirth;
  String? phoneNumber;
  String? email;
  String? password;
  String? accessStatus;
  String? country;
  int? roleId;
  int? points;

  appUser(
      this.appUserId,
      this.firstName,
      this.lastName,
      this.nickName,
      this.dateOfBirth,
      this.phoneNumber,
      this.email,
      this.password,
      this.accessStatus,
      this.country,
      this.roleId,
      this.points
      );



  appUser.getId(
      this.email,
      );

  appUser.getIdByPN(
     this.phoneNumber,
     );

  appUser.fromJson(Map<String, dynamic> json)
      : appUserId = json['appUserId'] as dynamic,
        firstName = json['firstName'] as String,
        lastName = json['lastName'] as String,
        nickName = json['nickName'] as String,
        dateOfBirth = json['dateOfBirth'] as String,
        phoneNumber = json['phoneNumber'] as String,
        email = json['email'] as String,
        password = json['password'] as String,
        accessStatus = json['accessStatus'] as String,
        country = json['country'] as String,
        roleId = json['roleId'] as dynamic,
        points = json['points'] as dynamic;

  //toJson will be automatically called by jsonEncode when necessary
  Map<String, dynamic> toJson() => {
    'appUserId': appUserId,
    'firstName': firstName,
    'lastName': lastName,
    'nickName': nickName,
    'dateOfBirth': dateOfBirth,
    'phoneNumber': phoneNumber,
    'email': email,
    'password': password,
    'accessStatus': accessStatus,
    'country': country,
    'roleId': roleId,
    'points': points,
  };


  Future<bool> getUserId() async {
    RequestController req = RequestController(path: "/api/company/getAppUserId.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      appUserId = req.result()['appUserId'];
      print(appUserId);
      return true;
    }
    else {
      return false;
    }
  }

}
