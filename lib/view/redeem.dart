
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
  int tourismServiceId=0;
  int crId=0;
  int rewardPoint=0;
  String dateRedeem='';

  // Format the date in yyyy-MM-dd format
  initState(){
    dateRedeem = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print("Here is date: ${dateRedeem}");

  }


  void proceedRedeem(rewardCode, phoneNumber) async{

    tourismServiceId = widget.company.tourismServiceId!;

    appUser user = appUser.getIdByPN(phoneNumber);

    if (await user.getUserId()){
      appUserId=user.appUserId!;

     Reward reward = Reward.getIdByCode(rewardCode);

     if (await reward.getRewardId()){
       rewardId=reward.rewardId!;
       rewardPoint = reward.rewardPoint!;

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
     }
    }
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
                SizedBox(height: 40),
                Center(
                  child: Text(
                    'REDEEM REWARD ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                SizedBox(height: 70),
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
                        buildTextField(
                          controller: phoneNumberController,
                          labelText: 'Phone Number',
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Add your redemption logic here
                            rewardCode = rewardCodeController.text;
                            phoneNumber = phoneNumberController.text;

                            proceedRedeem(rewardCode, phoneNumber);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Redeem(company: widget.company, initialIndex: widget.initialIndex)),
                            );
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