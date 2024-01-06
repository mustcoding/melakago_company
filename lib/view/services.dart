import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';

import '../Model/tourismService.dart';
import '../Model/tourismServiceImage.dart';
import 'bottomNavigation.dart';
import 'login.dart';




class editServices extends StatefulWidget {
  final tourismService company;
  final int initialIndex;

  editServices({required this.company, required this.initialIndex});

  @override
  State<editServices> createState() => _editServicesState();
}

class _editServicesState extends State<editServices> {

  String base64String='';
  String images='';
  String getImages='';
  int btypes=0;
  int? tourismServiceId=0;
  Uint8List? gambar;
  int isDelete=0;


  late TextEditingController tourismServiceIdController;
  late TextEditingController companyNameController;
  late TextEditingController companyAddressController;
  late TextEditingController businessContactNumberController;
  late TextEditingController emailController;
  late TextEditingController businessStartHourController;
  late TextEditingController businessEndHourController;
  late TextEditingController faxNumberController;
  late TextEditingController instagramController;
  late TextEditingController xTwitterController;
  late TextEditingController threadController;
  late TextEditingController facebookController;
  late TextEditingController businessLocationController;
  late TextEditingController starRatingController;
  late TextEditingController businessDescriptionController;
  late TextEditingController tsIdController;

  @override
  void initState() {
    super.initState();
    companyNameController = TextEditingController(text: widget.company.companyName);
    companyAddressController = TextEditingController(text:widget.company.companyAddress);
    businessContactNumberController = TextEditingController(text:widget.company.businessContactNumber);
    emailController = TextEditingController(text:widget.company.email);
    businessStartHourController = TextEditingController(text:widget.company.businessStartHour);
    businessEndHourController = TextEditingController(text:widget.company.businessEndHour);
    faxNumberController = TextEditingController(text:widget.company.faxNumber);
    instagramController = TextEditingController(text:widget.company.instagramURL);
    xTwitterController = TextEditingController(text:widget.company.xTwitterURL);
    threadController = TextEditingController(text:widget.company.threadURL);
    facebookController = TextEditingController(text: widget.company.facebookURL);
    businessLocationController = TextEditingController(text:widget.company.businessLocation);
    starRatingController = TextEditingController(text: widget.company.starRating.toString());
    businessDescriptionController = TextEditingController(text:widget.company.businessDescription);
    tsIdController = TextEditingController(text: widget.company.tsId.toString());

    tourismServiceId = widget.company.tourismServiceId;

    print("WOI: ${companyNameController.text}");

    if (tsIdController.text=="1"){
      tsIdController.text = "Shopping" ;
    }
    else if (tsIdController.text=="2"){
      tsIdController.text="Transport";
    }
    else if (tsIdController.text=="3"){

      tsIdController.text="Lodging";
    }
    else if (tsIdController.text=="4"){
      tsIdController.text="Restaurant";
    }
    else if (tsIdController.text=="5"){
      tsIdController.text="Activity";
    }
    else if (tsIdController.text=="6"){
      tsIdController.text="Tourist Spot";
    }
  }

  Future<bool> loadImages() async {
    int imageId = 0;
    tourismServiceImage serviceImage = tourismServiceImage(imageId, images, tourismServiceId!);
    if (await serviceImage.getImage()) {
      getImages = serviceImage.image;

      // Remove backslashes from the string
      getImages = getImages.replaceAll(r'\\', '');


      // Trim the string to remove any leading or trailing whitespaces
      getImages = getImages.trim();
      print("IMAAAAAAA: ${getImages}");

      // Check if the string contains the specified prefix
      if (getImages.startsWith("data:image\/jpeg;base64,")) {
        // Remove the prefix "data:image/jpeg;base64,"
        getImages = getImages.substring(getImages.indexOf(',') + 1);
        print("DATA HEREEEEEE: ${getImages}");
      }

      print("Images WOI: ${getImages}");
      return true;
    } else {
      getImages = "";
      return false;
    }
  }

  String? types;
  final PageController _pageController = PageController();

  List<Uint8List> selectedImages = [];


  void _AlertMessage(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text(msg),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'COMPANY PROFILE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          backgroundColor: Colors.lightGreen.shade700,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                // Add code to sign out here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => signIn()),
                );
              },
            ),
          ],
          automaticallyImplyLeading: false, // Add this line to remove the back button
        ),
        body: SingleChildScrollView(
          child: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                SizedBox(height: 80),
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: FutureBuilder<bool>(
                    future: loadImages(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // or another loading indicator
                      } else if (snapshot.hasError) {
                        return Text('Error loading image');
                      } else {
                        return Center(
                          child: Image.memory(
                            base64.decode(getImages),
                            width: 500,
                            height: 350,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 600.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Company Name', // Your label text
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0), // Add some space between the label and the text field
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: TextField(
                            controller: companyNameController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 600.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Company Address', // Your label text
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0), // Add some space between the label and the text field
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: TextField(
                            controller: companyAddressController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 205.0, // Set the width to the desired value
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Business Phone Number', // Your label text
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: TextField(
                                controller: businessContactNumberController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 205.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Business Email', // Your label text
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0), // Add some space between the label and the text field
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: TextField(
                                controller: emailController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 205.0, // Set the width to the desired value
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Business Start Hour', // Your label text
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: TextField(
                                controller: businessStartHourController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 205.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Business End Hour', // Your label text
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0), // Add some space between the label and the text field
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: TextField(
                                controller: businessEndHourController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 205.0, // Set the width to the desired value
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fax Number', // Your label text
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: TextField(
                                controller: faxNumberController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 205.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Instagram URL', // Your label text
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0), // Add some space between the label and the text field
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: TextField(
                                controller: instagramController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 205.0, // Set the width to the desired value
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'xTwitter URL', // Your label text
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: TextField(
                                controller: xTwitterController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 205.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thread URL', // Your label text
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: TextField(
                                controller: threadController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 205.0, // Set the width to the desired value
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Facebook URL', // Your label text
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: TextField(
                                controller: facebookController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 205.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Star Rating', // Your label text
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0), // Add some space between the label and the text field
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: TextField(
                                controller: starRatingController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 600.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Business Location', // Your label text
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0), // Add some space between the label and the text field
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: TextField(
                            controller: businessLocationController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 600.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Business Description', // Your label text
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0), // Add some space between the label and the text field
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: TextField(
                            controller: businessDescriptionController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 600,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Business Type',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: TextField(
                            controller: tsIdController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigation(company: widget.company, initialIndex: widget.initialIndex),
      ),
    );
  }
}
