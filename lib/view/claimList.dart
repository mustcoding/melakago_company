import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:melakago_web/Model/companyReward.dart';
import 'package:melakago_web/Model/redeemReward.dart';
import 'package:melakago_web/view/redeem.dart';
import 'package:melakago_web/view/services.dart';

import '../Controller/request_controller.dart';
import '../Model/tourismService.dart';
import 'bottomNavigation.dart';
import 'login.dart';


class claimList extends StatefulWidget {
  final tourismService company;
  final int initialIndex;
  const claimList({required this.company, required this.initialIndex});

  @override
  State<claimList> createState() => _claimListState();
}

class _claimListState extends State<claimList> {

  final List<redeemReward> rewardRedeemed = [];
  String dateRedeem='';
  int totalPointCollected=0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String dateRedeem = DateFormat('yyyy-MM').format(DateTime.now());
      print("DDDDDDAAATE: ${dateRedeem}");
      print("DKKDKDKDKDD: ${widget.company.tourismServiceId}");
      int? tourismServiceId = widget.company.tourismServiceId;

      redeemReward reward =
      redeemReward.searchByTSID(widget.company.tourismServiceId);
      rewardRedeemed.addAll(await reward.loadRewardRedeem());

      setState(() {
        for(int i=0 ; i<rewardRedeemed.length ; i++){
          totalPointCollected += int.parse(rewardRedeemed[i].pointsRedeemed!.toString());
        }

      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
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
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  Center(
                    child: Text(
                      'UNCLAIMED REWARD',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'COLLECTED POINTS: ${totalPointCollected}',  // Add your additional text here
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        // Add your additional content here
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: _buildListView(),
                  ),
                ],
              ),

          ),
          bottomNavigationBar: BottomNavigation(company: widget.company,  initialIndex: widget.initialIndex),
        ),
      );
  }

  Widget _buildListView() {
    return Container(
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: rewardRedeemed.length,
        itemBuilder: (context, index) {
          return Card(

            margin: EdgeInsets.all(8.0),
            color: Colors.lightGreenAccent,
            child: ListTile(
              title: Text('${rewardRedeemed[index].user?.firstName}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reward Name: ${rewardRedeemed[index].reward?.rewardName}'),
                  Text('Reward Code: ${rewardRedeemed[index].claimCode}'),
                  Text('Point Collected: ${rewardRedeemed[index].pointsRedeemed}'),
                  Text('Voucher Claimed: ${rewardRedeemed[index].dateRedeemed }'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
