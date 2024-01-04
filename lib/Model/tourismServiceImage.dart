import 'dart:typed_data';

import '../Controller/request_controller.dart';

class tourismServiceImage {

  int imageId;
  String image;
  int tourismServiceId;

  tourismServiceImage(
      this.imageId,
      this.image,
      this.tourismServiceId
      );

  tourismServiceImage.fromJson(Map<String, dynamic> json)
      : imageId = json['imageId'] as dynamic,
        image = json['image'] as String,
        tourismServiceId = json['tourismServiceId'] as dynamic;

  // toJson will be automatically called by jsonEncode when necessary
  Map<String, dynamic> toJson() => {
    'imageId': imageId,
    'image': image,
    'tourismServiceId': tourismServiceId,
  };

  Future<bool> saveImage() async {
    RequestController req = RequestController(path: "/api/tourismServiceImage.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 400)
    {
      return false;
    }
    else if (req.status() == 200)
    {
      return true;
    }
    else
    {
      return false;
    }
  }

  Future<bool> getImage() async {
    RequestController req = RequestController(path: "/api/getImage.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      imageId = req.result()['imageId'];
      image = req.result()['image'];
      tourismServiceId = req.result()['tourismServiceId'];
      return true;
    }
    else {
      return false;
    }
  }

}
