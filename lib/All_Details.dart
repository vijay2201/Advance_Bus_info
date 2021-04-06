

import 'package:admin_advance_bus_info/Full_Screen_LightBilldart.dart';
import 'package:admin_advance_bus_info/MainScreen.dart';
import 'package:admin_advance_bus_info/class_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Full_Screen_CollegeId.dart';
import 'Full_Screen_FeeReceipt.dart';

class AllDetails extends StatefulWidget {
  String userID;
  AllDetails({this.userID});

  @override
  _AllDetailsState createState() => _AllDetailsState();
}

class _AllDetailsState extends State<AllDetails> {
  final databaseRef = FirebaseDatabase.instance.reference();
  final _reasonController = TextEditingController();
  String reason;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: databaseRef
            .child("Data")
            .child(widget.userID)
            .child("PassData")
            .onValue,
        builder: (context, snap) {
          if (snap.hasData) {
            Map<dynamic, dynamic> data = snap.data.snapshot.value;
            if (data == null) {
              return Center(child: Text("No data"));
            } else {
              PassDetails userPassData = PassDetails();
              userPassData.userPhoto = data['UserPhoto'];
              userPassData.fullName = data['FullName'];
              userPassData.duration = data['Duration'];
              userPassData.gender = data['Gender'];
              userPassData.dateOfBirth = data["DateOFBirth"];
              userPassData.startDate = data['StartDate'];
              userPassData.emailAddress = data['EmailAddress'];
              userPassData.passType = data['PassType'];
              userPassData.collegeIdPhoto = data['CollegeIdPhoto'];
              userPassData.lightBillPhoto = data['LightBillPhoto'];
              userPassData.freeReceiptPhoto = data['FreeReceiptPhoto'];

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    userPassData.userPhoto.toString()))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8,bottom: 8),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child:
                              Text('Name : ${userPassData.fullName.toString()}')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              'Duration Of Pass: ${userPassData.duration.toString()}')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              'Email Address: ${userPassData.emailAddress.toString()}')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              'Start Date Of Pass: ${userPassData.startDate.toString()}')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              'Gender: ${userPassData.gender.toString()}')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              'Pass Type: ${userPassData.passType.toString()}')),
                    ),


                    SizedBox(height: 15,),
                    Center(
                      child: Text(
                        'Other Documents',
                        style:
                            TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                      ),
                    ),
                    SizedBox(height: 10,),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenCollegeId(
                        collegeId: userPassData.collegeIdPhoto.toString(),
                      )));
                    },
                    child: Hero(
                      tag: "College-id",
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          width: 90,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(userPassData.collegeIdPhoto.toString()),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenLightBill(
                        lightBill:  userPassData.lightBillPhoto.toString(),
                      )));
                    },
                    child: Hero(
                      tag: "Light Bill",
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 90,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(userPassData.lightBillPhoto.toString()),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenFreeReceipt(
                        feeReceipt: userPassData.freeReceiptPhoto.toString(),
                      )));
                    },
                    child: Hero(
                      tag: 'Free Receipt',
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          width: 90,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(userPassData.freeReceiptPhoto.toString()),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ],
                ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                            onChanged: (value) {
                                              reason = value;
                                            },
                                            maxLines: 5,
                                            controller: _reasonController,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "What's the Reason ?"),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Center(
                                              child: FlatButton(
                                                  hoverColor: Colors.green,
                                                  onPressed: () {
                                                    databaseRef
                                                        .child(
                                                            "AdminToEmployeeNotification")
                                                        .child(widget.userID)
                                                        .push()
                                                        .set({
                                                      "Message":
                                                          reason.toString()
                                                    }).then((value) {
                                                      Navigator.pop(context);
                                                      databaseRef
                                                          .child("Data")
                                                          .child(widget.userID)
                                                          .remove();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MainScreen()));
                                                    });
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  color: Colors.indigo,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Send",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                child: Text(
                                  'Decline',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        GestureDetector(

                          onTap: () {
                            databaseRef
                                .child("Data")
                                .child(widget.userID)
                                .child("PassData")
                                .update({"PassStatus": "Approved"});
                            databaseRef
                                .child("AdminToEmployeeNotification")
                                .child(widget.userID)
                                .push()
                                .set({
                              "Message": "Your pass generated successfully."
                            });
                          },
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.indigo),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 23, vertical: 12),
                                  child: Text(
                                    'Allow',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          } else if (snap.hasError) {
            return Center(child: Text("Error occured..!"));
          } else if (snap.hasData == false) {
            return Center(child: Text("No data"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

//       body: Padding(
//         padding: const EdgeInsets.only(bottom: 25),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 height: 85,
//                 width: 85,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     image: DecorationImage(
//                         image: AssetImage('assets/images/myUser.png'))),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8, top: 5),
//               child: Align(
//                   alignment: Alignment.topLeft,
//                   child: Text('Name : Prajapati VijayKumar Sureshbhai')),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Align(
//                   alignment: Alignment.topLeft,
//                   child: Text('Duration Of Pass: 2 Month')),
//             ),
//
//             Text(
//               'Other Documents',
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
//             ),
//
//             Container(
//               height: 120,
//               child: ListView.builder(
//                   physics: AlwaysScrollableScrollPhysics(),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 3,
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                       onTap: () {
//                         // Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenDoc()));
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           width: 90,
//                           height: 100,
//                           decoration: BoxDecoration(
//                               color: Colors.green,
//                               borderRadius: BorderRadius.circular(10)),
//                         ),
//                       ),
//                     );
//                   }),
//             ),
//             Row(
// mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: (){
//                     setState(() {
//                       editAddress(context);
//
//                     });
//                   },
//                   child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.red),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 12),
//                         child: Text(
//                           'Decline',
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.w500),
//                         ),
//                       )),
//                 ),
//                 SizedBox(width: 40,),
//                 Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.indigo),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 23, vertical: 12),
//                       child: Text(
//                         'Allow',
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.w500),
//                       ),
//                     )),
//               ],
//             )
//           ],
//         ),
//       ),
    );
  }
}

// Future<void> editAddress(BuildContext context) async {
//   final _reasonController = TextEditingController();
//
//
//   return
// }
