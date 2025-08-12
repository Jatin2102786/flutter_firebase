import 'package:flutter/material.dart';
import 'package:flutter_firebase/UI/PageFour/page_four.dart';
import 'package:flutter_firebase/UI/PageOne/page_one.dart';
import 'package:flutter_firebase/UI/PageThree/page_three.dart';
import 'package:flutter_firebase/UI/PageTwo/page_two.dart';

import '../Utils/colors.dart';

class BottomNavExample extends StatefulWidget {
  @override
  _BottomNavExampleState createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int _currentIndex = 0;


  final List<Widget> _pages = [
    PageOne(),
    PageTwo(),
    PageThree(),
    PageFour()
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dealit', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurpleAccent ,

      ),

      drawerEdgeDragWidth: 100,

      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // --- Customizing Colors for your Dealit app ---
        backgroundColor: AppColors.primary,
        // Dark background for the nav bar
        selectedItemColor: Colors.white,
        // Bright amber for the selected icon/label
        unselectedItemColor: AppColors.secondary,
        // Slightly transparent white for unselected
        onTap: _onTap,
        type: BottomNavigationBarType.shifting,
        // <--- Added this line
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.one_k),
            label: 'One',
            backgroundColor: AppColors.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.two_k),
            label: 'Two',
            backgroundColor: AppColors.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.three_k),
            label: "Three",
            backgroundColor: AppColors.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.four_k),
            label: "Four",
            backgroundColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

