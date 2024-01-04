import 'package:flutter/material.dart';
import 'package:melakago_web/view/redeem.dart';
import 'package:melakago_web/view/redeemHistory.dart';
import 'package:melakago_web/view/services.dart';
import '../Model/tourismService.dart';

class BottomNavigation extends StatefulWidget {
  final tourismService company;
  final int initialIndex;

  BottomNavigation({required this.company, required this.initialIndex});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.lightGreen.shade700,
      unselectedItemColor: Colors.black,
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Rewards',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Redeem',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (int index) {
        // Handle navigation based on the selected index
        setState(() {
          _currentIndex = index;
        });

        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => redeemHistory(company: widget.company, initialIndex:index),
            ),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Redeem(company: widget.company, initialIndex: index),
            ),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => editServices(company: widget.company, initialIndex: index),
            ),
          );
        }
      },
    );
  }
}