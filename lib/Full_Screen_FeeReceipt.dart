import 'package:flutter/material.dart';

class FullScreenFreeReceipt extends StatefulWidget {

   final feeReceipt;

  const FullScreenFreeReceipt({Key key, this.feeReceipt}) : super(key: key);
  @override
  _FullScreenFreeReceiptState createState() => _FullScreenFreeReceiptState();
}

class _FullScreenFreeReceiptState extends State<FullScreenFreeReceipt> {
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onHorizontalDragStart: (DragStartDetails dragStartDetails) {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Free Receipt",style: TextStyle(color: Colors.black),),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Hero(
          tag: "Fee Receipt",
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.feeReceipt),
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
