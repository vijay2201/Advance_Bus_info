import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

import 'MainScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLogIn = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: Colors.white,
      isLoading: isLogIn,
      opacity: 0.8,
      progressIndicator: SpinKitCircle(
        color: Colors.indigo,
        size: 30,
      ),

      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/animation/27715-login-anim.json',),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      validator: (value){
                        if(value.isEmpty)
                          {
                            return "Please Enter Email";
                          }
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Your Email",

                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Icon(Icons.email_rounded),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 12, bottom: 8),
                    child: TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return "Enter Password";

                        }
                        else
                          return null ;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Your Password",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Icon(Icons.lock_rounded),
                        ),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      color: Colors.indigo,
                      padding:
                          EdgeInsets.only(left: 60, right: 60, top: 10, bottom: 10),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () async {
                        try {

                          if (_formKey.currentState.validate()){
                            final newUser = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (newUser != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      FirebaseAuth.instance.currentUser == null ? MyHomePage() : MainScreen()));
                              email = "";
                              password = "";
                            }


                          }

                        } catch (e) {
                          print(e.toString());
                          isLogIn = false;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
