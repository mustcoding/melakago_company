
import 'package:flutter/material.dart';
import 'package:melakago_web/view/redeemHistory.dart';
import 'package:melakago_web/view/services.dart';

import '../Model/appUser.dart';
import '../Model/companyReward.dart';
import '../Model/redeemReward.dart';
import '../Model/reward.dart';
import '../Model/tourismService.dart';
import 'bottomNavigation.dart';
import 'package:intl/intl.dart';

import 'login.dart';



class Redeem extends StatefulWidget {
  final tourismService company;
  final int initialIndex;

  Redeem({required this.company, required this.initialIndex});

  @override
  _RedeemState createState() => _RedeemState();
}

class _RedeemState extends State<Redeem> {
  TextEditingController rewardCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String rewardCode = '';
  String phoneNumber = '';
  int appUserId=0;
  int rewardId=0;
  int redeemId=0;
  int tourismId=0;
  int tourismServiceId=0;
  int crId=0;
  int rewardPoint=0;
  String dateRedeem='';

  // Format the date in yyyy-MM-dd format
  initState(){
    dateRedeem = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print("Here is date: ${dateRedeem}");

  }

  void proceedRedeem(rewardCode, appUserId) async{

    tourismServiceId = widget.company.tourismServiceId!;
    print("tourismServideId= ${tourismServiceId}");

     Reward reward = Reward.getIdByCode(rewardCode);

     if (await reward.getRewardId()){
       rewardId=reward.rewardId!;
       rewardPoint = reward.rewardPoint!;
       tourismId = reward.tourismServiceId!;
       print("tototo: ${tourismId}");

       if (tourismId == tourismServiceId){

         redeemReward redeem = redeemReward.getRedeemId(appUserId, rewardId);
         if(await redeem.getRedeemRewardId())
         {
           redeemId = redeem.redeemId!;

           /*// Format the date in yyyy-MM-dd format
          dateRedeem = DateFormat('yyyy-MM-dd').format(DateTime.now());*/
           companyReward manageReward = companyReward.Add(crId, rewardId, appUserId,
               tourismServiceId, dateRedeem, rewardPoint);

           if(await manageReward.saveRedeemByCompany()){

             redeemReward redeem = redeemReward.updateRedeemReward(redeemId, appUserId, rewardId);
             if (await redeem.updateStatus()){
               _showMessage("Redeem Reward Successfull");
             }
           }
         }
         else{
           _AlertMessage("No Available Reward");
         }

       }
       else{
         _AlertMessage("Reward Can't being redeem at your company");
       }

     }

  }

  void _AlertMessage(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }


  void _showMessage(String msg){
    if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );
    }
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
              '${widget.company.companyName}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 70),
                Center(
                  child: Text(
                    'REDEEM REWARD ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    color: Colors.lightGreen.shade100, // Set your desired color
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        buildTextField(
                          controller: rewardCodeController,
                          labelText: 'Reward Code',
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Add your redemption logic here
                            String rewardUserCode = rewardCodeController.text;

// Split the code into two parts:
                            List<String> codeParts = rewardUserCode.split('');  // Split by individual characters
                            String rewardCode = codeParts.sublist(0, 5).join();  // Extract first 5 characters

                            try {
                              // Extract remaining characters and convert to an integer
                              appUserId = int.parse(codeParts.sublist(5).join());

                              // Check if rewardUserCode doesn't contain any part of rewardCode and appUserId
                              if (rewardUserCode.contains(rewardCode)) {
                                proceedRedeem(rewardCode, appUserId);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Redeem(company: widget.company, initialIndex: widget.initialIndex)),
                                );
                              } else {
                                // Your logic when rewardUserCode contains some part of rewardCode
                                _AlertMessage("Invalid rewardCode");
                              }
                            } catch (e) {
                              // Handle the case when the second part is not an integer
                              _AlertMessage("Invalid rewardCode");
                            }

                            // Use the extracted values:
                            print("Reward Code: $rewardCode");  // Output: Reward Code: RW011
                            print("App User ID: $appUserId");   // Output: App User ID: 12


                          },
                          child: Text('Redeem Now', style:TextStyle(color:Colors.purple)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigation(company: widget.company, initialIndex: widget.initialIndex),
      ),
    );
  }

  Widget buildTextField({required TextEditingController controller, required String labelText}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}