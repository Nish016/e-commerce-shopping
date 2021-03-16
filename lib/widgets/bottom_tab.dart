import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTab extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;

  BottomTab({this.selectedTab, this.tabPressed});

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _selectedTab = 0;


  @override
  Widget build(BuildContext context) {

    _selectedTab = widget.selectedTab ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.10),blurRadius: 30.0, spreadRadius: 1.0)
        ]
      ),
    
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
            imagePath: 'assets/home.png',
            selected: _selectedTab == 0 ? true : false,
            onPressed: (){
             widget.tabPressed(0);
            },
          ),
          BottomTabBtn(
            imagePath: 'assets/search.png',
            selected: _selectedTab == 1 ? true : false,
              onPressed: (){
             widget.tabPressed(1);
            },
          ),
          BottomTabBtn(
            imagePath: 'assets/save.png',
            selected: _selectedTab == 2 ? true : false,
              onPressed: (){
             widget.tabPressed(2);
            },
          ),
          BottomTabBtn(
            imagePath: 'assets/signout.png',
            selected: _selectedTab == 3 ? true : false,
             onPressed: (){
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;

  BottomTabBtn({this.imagePath , this.selected,this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onPressed,
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 22.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _selected ? Theme.of(context).accentColor : Colors.transparent , width: 2.0),
        ),
        ),
        child: Image(
          image: AssetImage(imagePath ?? 'assets/home.png'),
          width: 26.0,
          height: 26.0,
          color:  _selected ? Theme.of(context).accentColor : Colors.black ,
        ),
      ),
    );
  }
}
