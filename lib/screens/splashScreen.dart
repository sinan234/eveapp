import 'package:eveapp/main.dart';
import 'package:eveapp/screens/homepage.dart';
import 'package:eveapp/screens/login.dart';
import 'package:eveapp/screens/signup.dart';
import 'package:eveapp/screens/ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {

const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;






@override
Widget build(BuildContext context) {
  Future.delayed(Duration(seconds: 5), () {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) =>  UISCreen()));
  });
  return Scaffold(body: Container(color: Colors.black, child: Center(
    child:Image.asset('assets/images/logo_icon.png',width: 396,height: 1596,),
  ),));
}
}

