import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopping/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping/screens/home_page.dart';
import 'package:shopping/screens/login_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              // if stream snapshot has error
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text('Error: ${streamSnapshot.error}')),
                );
              }

              if(streamSnapshot.connectionState == ConnectionState.active)
              {
                  // get the user
                  User _user = streamSnapshot.data;

                  //if user is null we are not logged in

                  if(_user == null)
                  {
                    return LoginPage();
                  }
                  else 
                  {
                    return HomePage();
                  }
              }

          //checking the auth state

          return Scaffold(
          body: Center(
              child: Text('Checking auth state',
                  style: Constants.regularheading)),
        );  
            },
          );
        }

        return Scaffold(
          body: Center(
              child: Text('Initialization App...',
                  style: Constants.regularheading)),
        );
      },
    );
  }
}
