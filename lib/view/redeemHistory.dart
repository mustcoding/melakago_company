import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:melakago_web/Model/companyReward.dart';
import 'package:melakago_web/view/redeem.dart';
import 'package:melakago_web/view/services.dart';

import '../Controller/request_controller.dart';
import '../Model/tourismService.dart';
import 'bottomNavigation.dart';
import 'login.dart';


class redeemHistory extends StatefulWidget {
  final tourismService company;
  final int initialIndex;
  const redeemHistory({required this.company, required this.initialIndex});

  @override
  State<redeemHistory> createState() => _redeemHistoryState();
}

class _redeemHistoryState extends State<redeemHistory> {

  final List<companyReward> rewardRedeemed = [];
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

      companyReward rewardRedeem =
      companyReward.getList(tourismServiceId, dateRedeem);
      rewardRedeemed.addAll(await rewardRedeem.loadCompanyRedeem());

      setState(() {
        for(int i=0 ; i<rewardRedeemed.length ; i++){
          totalPointCollected += int.parse(rewardRedeemed[i].pointRedeem!.toString());
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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                Center(
                  child: Text(
                    'REDEEM HISTORY',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'COLLECTED POINTS / MONTH: ${totalPointCollected}',  // Add your additional text here
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      // Add your additional content here
                    ],
                  ),
                ),
                _buildListView(),
              ],
            ),
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
            child: ListTile(
              title: Text('${rewardRedeemed[index].reward?.rewardName}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reward Code: ${rewardRedeemed[index].reward?.rewardCode}'),
                  Text('Point Collected: ${rewardRedeemed[index].pointRedeem}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
