import 'package:flutter/material.dart';
import 'package:shopping/tabs/home_tab.dart';
import 'package:shopping/tabs/saved_tab.dart';
import 'package:shopping/tabs/search_tab.dart';
import 'package:shopping/widgets/bottom_tab.dart';
import 'package:shopping/widgets/firebase_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseServices _firebaseServices = FirebaseServices();

  PageController _tabPageController;
  int _selectedTab = 0; 

  @override
  void initState() {
    _tabPageController = PageController();
    super.initState();
  }


@override
  void dispose() {
    _tabPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Expanded(
             child: PageView(
                controller: _tabPageController,
                onPageChanged: (num) {
                    setState(() {
                      _selectedTab = num;
                    });
                },
                children: [
                  HomeTab(),
                  SearchTab(),
                  SavedTab()
                ],
              ),
            ),
          ),
            BottomTab(
              selectedTab: _selectedTab,
              tabPressed: (num) {
                _tabPageController.animateToPage(
                  num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
              },

            ),
        ],
      ),
    );
  }
}