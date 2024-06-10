// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:first/pages/Settings_page.dart';
import 'package:first/pages/home_page.dart';
import 'package:first/pages/profile_page.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    //Home page
    HomePage(),
    //Profile page
    ProfilePage(),
    //Setting page
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pratique bottom navigation"),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        items: [
          // homme
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          // Profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
          // Profile
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
