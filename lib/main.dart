import 'dart:async';

import 'package:eveapp/screens/details.dart';
import 'package:eveapp/screens/homepage.dart';
import 'package:eveapp/screens/login.dart';
import 'package:eveapp/screens/signup.dart';
import 'package:eveapp/screens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
  
  MyApp(
    
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  User? user;
  Completer<GoogleMapController> _controller = Completer();


  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        '/signin':(context) => const Login(),
        '/signup':(context) => const SignUP()
      },
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
  
}