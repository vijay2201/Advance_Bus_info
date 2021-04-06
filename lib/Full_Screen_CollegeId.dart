

import 'package:flutter/material.dart';

class FullScreenCollegeId extends StatefulWidget {

  final collegeId;



  const FullScreenCollegeId({Key key, this.collegeId}) : super(key: key);



  @override
  _FullScreenCollegeIdState createState() => _FullScreenCollegeIdState();
}

class _FullScreenCollegeIdState extends State<FullScreenCollegeId> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails dragStartDetails) {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("College Id",style: TextStyle(color: Colors.black),),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Hero(
          tag: "College-id",
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              // color: Colors.red,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.collegeId),
                  fit: BoxFit.cover
                )
              ),

            ),
          ),
        ),
      ),
    );
  }
}
