import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/map_screen.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue[500],
        backgroundColor: Colors.blue[600],
        accentColor: Colors.purpleAccent,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.green,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        )
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder:(ctx, userSnapshot){
          if (userSnapshot.hasData){
            return MapsScreen();
          }
          return AuthScreen();
        }),
    );
  }
}

