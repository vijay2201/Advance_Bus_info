import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {



  String name;
  String age;
  String title;
  String userID;
  String useremail;
  // Map<dynamic,dynamic> demo;
  final databaseRef = FirebaseDatabase.instance.reference().child("Data");
  List  lists = [];
  final auth = FirebaseAuth.instance;
  // List<String> names = [];
  // List<dynamic> ages = [];

  bool isLoading = true;

  getCurrentuse() async {
    final user = await auth.currentUser;
    final uid = user.uid;
    userID = uid;
    setState(() {
      isLoading = false;
    });
    print('User ID:  '+userID);
    useremail = user.email;
    print(user.email);
  }

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentuse();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getCurrentuse();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin of Advance Bus Info '),
      ),
      body: Form(
        key: _formkey,
        child: Container(
          height: 300,
          child: isLoading ? CircularProgressIndicator() :
          FutureBuilder(
              future: databaseRef.once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                if (snapshot.hasData) {
                  lists.clear();
                  Map<dynamic, dynamic> values = snapshot.data.value;
                  values.forEach((key, values) {
                    lists.add(values);
                  });
                  return new ListView.builder(
                      shrinkWrap: true,
                      itemCount: lists.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Full Name: " + lists[index]["Full Name"]),

                            ],
                          ),
                        );
                      });
                }
                return CircularProgressIndicator();
              })
        ),
      ),
    );
  }
}
