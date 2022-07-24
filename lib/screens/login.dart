import 'package:eveapp/screens/details.dart';
import 'package:eveapp/screens/homepage.dart';
import 'package:eveapp/screens/signup.dart';
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
    final _formKey = GlobalKey<FormState>();
    TextEditingController _username = TextEditingController();
    TextEditingController _password = TextEditingController();


    void userlogin(String email, String password) async {
                          if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
      try {
        await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) =>  Details()));
      }on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('EMAIL IS INCORRECT')),
                  );
  } else if (e.code == 'wrong-password') {
    print('WRONG PASSWORD ');
    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PASSWORD IS INCORRECT')),
                  );
  }
  print(e.code);
      }
      
    }

    return (Scaffold(
        appBar: AppBar(
          title: const Text('Provider Login'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
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
                    validator: (value) {
                      
                          if (value == null || value.isEmpty) {
                            return 'Enter your Password';
                          }
                   
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
                  InkWell(
                    onTap: () {
                      userlogin(_username.text, _password.text);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blue),
                        height: 50,
                        width: double.infinity,
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                  TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUP(),
                          )),
                      child: const Text("SignUp For New Providers"))
                ],
              ),
            ),
          ),
        )));
  }
}
