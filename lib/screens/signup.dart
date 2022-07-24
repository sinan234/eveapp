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
  String? password1;
  String? password2;
  final _formKey  = GlobalKey<FormState>();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  void usersignup(String email, String password) async {
    if (_formKey.currentState!.validate()) {
                 
                }
    if(password1!=password2){
      ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords not maching')),
                  );
    }else{

    try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
    }on FirebaseAuthException catch (e) {
       if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('The password provided is too weak.')),
                  );
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('email-already-in-use')),
                  );
    print('The account already exists for that email.');
  }
    }
    }
    

        
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: const Text('Provider Signup'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
            child: Form(
              key: _formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    validator: (value) {
                        
                            if (value == null || value.isEmpty) {
                              return 'Enter your Email';
                            }
                            
                     
                      },
                    decoration: const InputDecoration(
                      hintText: "Enter Your Email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      prefixIcon: Icon(
                        Icons.person_pin_circle_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    controller: _username,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                        
                            if (value == null || value.isEmpty) {
                              return 'Enter your password';
                            }else if(value.length<7){
                              return "minimum 6 digit password reqiured";
                            }
                            setState(() {
                              password1 = value;
                            });
                     
                      },
                    decoration: const InputDecoration(
                      hintText: "Enter Your Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                    ),
                    controller: _password,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                        
                            if (value == null || value.isEmpty) {
                              return 'Enter your password';
                            }
                            setState(() {
                              password2=value;
                            });
                     
                      },
                    decoration: const InputDecoration(
                      hintText: "Confirm Your Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                    )
                    
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                      InkWell(
                    onTap: () {
                                        usersignup(_username.text, _password.text);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blue),
                        height: 50,
                        width: double.infinity,
                        child: const Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                
                  TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/signin'),
                      child: const Text("Already have an Account? Sign In"))
                ],
              ),
            ),
          ),
        )));
  }
}
