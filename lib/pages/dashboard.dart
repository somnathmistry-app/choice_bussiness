import 'package:choice_bussiness/pages/addService.dart';
import 'package:choice_bussiness/pages/leadpage.dart';
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
    LeadsPage(),
    const AddService(),
    const RatingPage(),
    ProfileScreen(),
  ];
  final _pageController = PageController(initialPage: 0);
  Future<bool> _showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App?'),
        content: const Text('Do you want to exit Choice99?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
            child:const Text('No',style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
            child:const Text('Yes',style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    )??false; //if showDialog had returned null, then return false
  }
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _showExitPopup,
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          items:  [
            CurvedNavigationBarItem(
              child: Icon(Icons.home_repair_service),
              label: 'Services',
            ),
            CurvedNavigationBarItem(
              child: Stack(
                children: <Widget>[
                  new IconButton(icon: Icon(Icons.list), onPressed: () {
                    setState(() {
                      counter = 0;
                    });
                  }),
                  //counter != 0 ? new

                  Positioned(
                    left: 6,
                    top: 5,
                    child: new Container(
                      padding: EdgeInsets.all(2),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '$counter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )

                      //: new Container()
                ],
              ),
              label: 'Leads',
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
      ),
    );
  }
}
