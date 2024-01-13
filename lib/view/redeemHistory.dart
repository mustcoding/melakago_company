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

  List<companyReward> originalRedeemed = [];
  final List<companyReward> rewardRedeemed = [];
  String dateRedeem='';
  int totalPointCollected=0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      int? tourismServiceId = widget.company.tourismServiceId;

      companyReward rewardRedeem =
      companyReward.getList(tourismServiceId);
      originalRedeemed.addAll(await rewardRedeem.loadCompanyRedeem());

      setState(() {
        rewardRedeemed.addAll(originalRedeemed);

        for (int i = 0; i < rewardRedeemed.length; i++) {
          totalPointCollected +=
              int.parse(rewardRedeemed[i].pointRedeem!.toString());
        }
      });
    });
  }


  void _search() {
    String searchKeyword = searchController.text.trim();
    List<companyReward> searchedList = [];

    for (int i = 0; i < originalRedeemed.length; i++) {
      String dateRedeemed = originalRedeemed[i].dateRedeem ?? '';
      if (dateRedeemed.contains(searchKeyword)) {
        searchedList.add(originalRedeemed[i]);
      }
    }

    setState(() {
      totalPointCollected = 0;
      rewardRedeemed.clear();
      rewardRedeemed.addAll(searchedList);

      for (int i = 0; i < rewardRedeemed.length; i++) {
        totalPointCollected +=
            int.parse(rewardRedeemed[i].pointRedeem!.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => signIn()),
                );
              },
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
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
                    SizedBox(height: 5),
                    Text(
                      'TOTAL   COLLECTED POINTS: $totalPointCollected',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Enter Month and Year (e.g., YYYY-MM)',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _search,
                          child: Text('Search'),
                        ),
                      ],
                    ),
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
        bottomNavigationBar: BottomNavigation(
          company: widget.company,
          initialIndex: widget.initialIndex,
        ),
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
                  Text('Reward Code: ${rewardRedeemed[index].reward?.rewardCode}'+'${rewardRedeemed[index].appUserId}'),
                  Text('Point Collected: ${rewardRedeemed[index].pointRedeem}'),
                  Text('Date Redeemed: ${rewardRedeemed[index].dateRedeem }'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
