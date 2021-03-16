import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping/constants.dart';
import 'package:shopping/widgets/custom_input.dart';
import 'package:shopping/widgets/firebase_services.dart';
import 'package:shopping/widgets/product_card.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString ="";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if(_searchString.isEmpty)
          Center(
            child: Container(
              child: Text('Search Results',
              style: Constants.regularDarkText),
            ),
          )

          else 
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef.orderBy('search_string')
            .startAt([_searchString]) 
            .endAt(['$_searchString\uf8ff']) 
            .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text('Error: ${snapshot.error}')),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                //Data is ready to display
                return ListView(
                    padding: EdgeInsets.only(top: 130.0, bottom: 12.0),
                    children: snapshot.data.docs.map((document) {
                      
                      return ProductCard(
                        title: document.data()['name'],
                        imageUrl: document.data()['images'][0],
                        price: '\Rs ${document.data()['price']}',
                        productId: document.id,
                      );
                    }).toList());
              }

              //Loading State
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: CustomInput(
              hintText: 'Search Here',
              onSubmitted: (value) {
                  setState(() {
                    _searchString = value.toLowerCase();
                  });
                
              },
            ),
          ),
        ],
      ),
    );
  }
}
