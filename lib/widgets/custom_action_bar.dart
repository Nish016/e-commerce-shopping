import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:shopping/constants.dart';
import 'package:shopping/screens/cart_page.dart';
import 'package:shopping/widgets/firebase_services.dart';

class CustomActionBar extends StatelessWidget {
  final String title; 
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;

  CustomActionBar(
      {this.title, this.hasBackArrow, this.hasTitle, this.hasBackground});

  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _usersRef =
        FirebaseFirestore.instance.collection("Users"); 

    

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;


    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(
                  colors: [Colors.white, Colors.grey.withOpacity(0)],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1))
              : null),
      padding: EdgeInsets.fromLTRB(24.0, 56.0, 24.0, 42.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)

            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,

                child: Image(
                    image: AssetImage('assets/backarrow.jpg'),
                    color: Colors.white,
                    width: 22.0,
                    height: 22.0),
              ),
            ),
          if (_hasTitle)
            Text(title ?? 'Action Bar', style: Constants.boldheading),
          
          
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage()));
            },
              child: Container(
              width: 42.0,
              height: 42.0,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(8.0)),
              alignment: Alignment.center,

              child: StreamBuilder(
                  stream: _usersRef.doc(_firebaseServices.getUserId()).collection("Cart").snapshots(),
                  builder: (context, snapshot) {
                     
                    int _totalItems = 0;

                    if (snapshot.connectionState == ConnectionState.active) {
                      List _documents = snapshot.data.docs;
                      _totalItems = _documents.length;
                    }

                    return Text(
                      "$_totalItems"?? "0",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    );
                  }
                  ),
            ),
          )
        ],
      ),
    );
  }
}
