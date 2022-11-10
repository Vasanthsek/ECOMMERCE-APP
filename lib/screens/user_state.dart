import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'landing_page.dart';
import 'main_screen.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.hasData) {
              print('The user is already logged in');
              return const MainScreen();
            } else  {
              print('The user didn\'t login yet');
              return LandingPage();
            }
          } else if (userSnapshot.hasError) {
            return const Center(
              child:  Text('Error occured'),
            );
          }return const Text(""); // throw(context) - anything is fine both will work
        }
        );
  }
}