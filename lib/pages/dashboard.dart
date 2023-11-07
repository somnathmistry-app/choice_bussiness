import 'package:choice_bussiness/pages/addService.dart';
import 'package:choice_bussiness/pages/bookingPage.dart';
import 'package:choice_bussiness/pages/profile.dart';
import 'package:choice_bussiness/pages/ratingspage.dart';
import 'package:choice_bussiness/pages/services.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> bottomBarPages = [
    const ServicesPage(),
    const BookingPage(),
    const AddService(),
    const RatingPage(),
    ProfileScreen(),
  ];
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_repair_service),
            label: 'Services',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.book_outlined),
            label: 'Bookings',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.add_circle),
            label: 'AddService',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.newspaper),
            label: 'Ratings',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.perm_identity),
            label: 'Profile',
          ),
        ],
        color: Colors.white,
        backgroundColor: AppColors.themeColor,

        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
        letIndexChange: (index) => true,
      ),
      body:

      PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
    );
  }
}
