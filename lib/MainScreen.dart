
import 'package:admin_advance_bus_info/All_Details.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final databaseRef = FirebaseDatabase.instance.reference();

  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Admin',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600),),

      ),
      body: ListView(
        children: [
          StreamBuilder(
            stream: databaseRef.child("Data").onValue,
            builder: (context, snap){
              if(snap.hasData){
                Map<dynamic, dynamic> data = snap.data.snapshot.value;
                // print(data.keys);
                if(data == null){
                  return Center(child: Text("No Passes Application"));
                }

                List<dynamic> userKey = [];
                List<dynamic> userPhotos = [];
                List<dynamic> userEmail = [];
                List<dynamic> userName= [];
                List<dynamic> userMap = [];

                data.forEach((key, value) {
                  userKey.add(key);
                  userMap.add(value['PassData']);
                  userName.add(value['FullName']);
                  userEmail.add(value['EmailAddress']);
                  userPhotos.add(value['UserPhoto']);
                });


                return Container(
                        height: 500,
                        child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: userMap.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context,int index){
                          return Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 85,
                                  width: 85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                      image: NetworkImage(userPhotos[index].toString())
                                    )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text('Name : ${userName[index].toString()}'),
                                      SizedBox(height: 3,),
                                      Text('Email : ${userEmail[index].toString()}'),
                                      SizedBox(height: 3,),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: RaisedButton(onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => AllDetails(userID: userKey[index].toString())));
                                        },child: Text('All Details',style: TextStyle(color: Colors.white),),color: Colors.indigo,),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          );
                }),
                      );
              }
              else if (snap.hasError) {
                return Center(child: Text("Error occured..!"));
              } else if (snap.hasData == false) {
                return Center(child: Text("No data"));
              } else {
                return Center(
                    child: CircularProgressIndicator());
              }
            },
          ),

        ],
      ),
    );
  }
}
