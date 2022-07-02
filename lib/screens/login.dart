import 'package:eveapp/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
 TextEditingController _username =TextEditingController();
    TextEditingController _password =TextEditingController();
    void userlogin(String email, String password)async {
   await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen() )));
  }
    return(

      Scaffold(appBar: AppBar()
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
        ElevatedButton(onPressed: (){userlogin(_username.text, _password.text);}, child: Text("login",))
        

      ]
        ,)
        
      )   );
  }
}