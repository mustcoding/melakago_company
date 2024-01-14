import 'dart:convert';

import '../Controller/request_controller.dart';

class tourismService {

  int? tourismServiceId;
  String? companyName;
  String? companyAddress;
  String? businessContactNumber;
  String? email;
  String? businessStartHour;
  String? businessEndHour;
  String? faxNumber;
  String? instagramURL;
  String? xTwitterURL;
  String? threadURL;
  String? facebookURL;
  String? businessLocation;
  int? starRating;
  String? businessDescription;
  int? tsId;
  int? isDelete;

  tourismService(
      this.tourismServiceId,
      this.companyName,
      this.companyAddress,
      this.businessContactNumber,
      this.email,
      this.businessStartHour,
      this.businessEndHour,
      this.faxNumber,
      this.instagramURL,
      this.xTwitterURL,
      this.threadURL,
      this.facebookURL,
      this.businessLocation,
      this.starRating,
      this.businessDescription,
      this.tsId,
      this.isDelete
      );

  tourismService.getId(
      this.companyName,
      this.companyAddress,
      this.businessContactNumber,
      );

  tourismService.newJ(
      this.tourismServiceId,
      );

  tourismService.getEmail(
      this.email,
      );

  tourismService.getIdQuiz(
      this.companyName,
      );

  tourismService.fromJson(Map<String, dynamic> json)
      : tourismServiceId = json['tourismServiceId'] as dynamic?,
        companyName = json['companyName'] as String? ?? '',
        companyAddress = json['companyAddress'] as String? ?? '',
        businessContactNumber = json['businessContactNumber'] as String? ?? '',
        email = json['email'] as String? ?? '',
        businessStartHour = json['businessStartHour'] as String? ?? '',
        businessEndHour = json['businessEndHour'] as String? ?? '',
        faxNumber = json['faxNumber'] as String? ?? '',
        instagramURL = json['instagramURL'] as String? ?? '',
        xTwitterURL = json['xTwitterURL'] as String? ?? '',
        threadURL = json['threadURL'] as String? ?? '',
        facebookURL = json['facebookURL'] as String? ?? '',
        businessLocation = json['businessLocation'] as String? ?? '',
        starRating = json['starRating'] as dynamic?,
        businessDescription = json['businessDescription'] as String? ?? '',
        tsId = json['tsId'] as dynamic?,
        isDelete = json['isDelete'] as dynamic?;

  //toJson will be automatically called by jsonEncode when necessary
  Map<String, dynamic> toJson() => {
    'tourismServiceId': tourismServiceId,
    'companyName': companyName,
    'companyAddress': companyAddress,
    'businessContactNumber': businessContactNumber,
    'email': email,
    'businessStartHour': businessStartHour,
    'businessEndHour': businessEndHour,
    'faxNumber': faxNumber,
    'instagramURL': instagramURL,
    'xTwitterURL': xTwitterURL,
    'threadURL': threadURL,
    'facebookURL': facebookURL,
    'businessLocation': businessLocation,
    'starRating': starRating,
    'businessDescription': businessDescription,
    'tsId': tsId,
    'isDelete': isDelete,
  };



  Future<bool> getServiceId() async {
    RequestController req = RequestController(path: "/api/getTourismServiceId.php");
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



  Future<bool> getService() async {
    RequestController req = RequestController(path: "/api/countTourismService.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      Map<String, dynamic> result = req.result();

      if (result.containsKey('tourismServiceId')) {

        tourismServiceId = result['tourismServiceId'] as int?;
        companyName = result['companyName'] as String? ?? '';
        companyAddress = result['companyAddress'] as String? ?? '';
        businessContactNumber = result['businessContactNumber'] as String? ?? '';
        email = result['email'] as String? ?? '';
        businessStartHour = result['businessStartHour'] as String? ?? '';
        businessEndHour = result['businessEndHour'] as String? ?? '';
        faxNumber = result['faxNumber'] as String? ?? '';
        instagramURL = result['instagramURL'] as String? ?? '';
        xTwitterURL = result['xTwitterURL'] as String? ?? '';
        threadURL = result['threadURL'] as String? ?? '';
        facebookURL = result['facebookURL'] as String? ?? '';
        businessLocation = result['businessLocation'] as String? ?? '';
        starRating = result['starRating'] as int?;
        businessDescription = result['businessDescription'] as String? ?? '';

      }
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> checkCompanyExistence() async {
    RequestController req =
    RequestController(path: "/api/company/checkCompanyExistence.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      tourismServiceId=req.result()['tourismServiceId'];
      companyName=req.result()['companyName'];
      companyAddress=req.result()['companyAddress'];
      businessContactNumber=req.result()['businessContactNumber'];
      email=req.result()['email'];
      businessStartHour=req.result()['businessStartHour'];
      businessEndHour=req.result()['businessEndHour'];
      faxNumber=req.result()['faxNumber'];
      instagramURL=req.result()['instagramURL'];
      xTwitterURL=req.result()['xTwitterURL'];
      threadURL=req.result()['threadURL'];
      facebookURL=req.result()['facebookURL'];
      businessLocation=req.result()['businessLocation'];
      starRating=req.result()['starRating'];
      businessDescription=req.result()['businessDescription'];
      tsId=req.result()['tsId'];
      isDelete=req.result()['isDelete'];
      return true;
    }
    else {
      return false;
    }
  }

}
