import 'package:eveapp/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'homepage.dart';

class SignUP extends StatefulWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
      TextEditingController _username =TextEditingController();
    TextEditingController _password =TextEditingController();
    void usersignup(String email, String password)async {
   await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen() )));
  }
  @override
  Widget build(BuildContext context) {
    return( Scaffold(appBar: AppBar()
      ,
      body: Column(
      children: [
        TextFormField(
          decoration:InputDecoration(
            hintText: "username"
          ),
          controller: _username,
        ),
        TextFormField(
          decoration:InputDecoration(
            hintText: "password"
          ),
          controller: _password,
        ),
        ElevatedButton(onPressed: (){usersignup(_username.text, _password.text);}, child: Text("sign up",)),
        TextButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),)), child: Text("already have a ACCOUNT? sign in."))
      


      ]
        ,)
        
      )   );
    
   
  }
}