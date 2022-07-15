import 'package:eveapp/main.dart';
import 'package:eveapp/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {

const SplashScreen({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  Future.delayed(Duration(seconds: 5), () {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => MapScreen()));
  });
  return Scaffold(body: Container(color: Colors.white, child: Center(
    child:Image.asset('assets/images/logo_icon.png',width: 396,height: 1596,),
  ),));
}

}

