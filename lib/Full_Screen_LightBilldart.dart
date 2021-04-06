import 'package:flutter/material.dart';

class FullScreenLightBill extends StatefulWidget {
  final lightBill;

  const FullScreenLightBill({Key key, this.lightBill}) : super(key: key);
  @override
  _FullScreenLightBillState createState() => _FullScreenLightBillState();
}

class _FullScreenLightBillState extends State<FullScreenLightBill> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails dragStartDetails) {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Light Bill",style: TextStyle(color: Colors.black),),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Hero(
          tag: "Light Bill",
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,

              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.lightBill),
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
