import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LoadLimit extends StatefulWidget {
  const LoadLimit({Key? key}) : super(key: key);

  @override
  State<LoadLimit> createState() => _LoadLimitState();
}

class _LoadLimitState extends State<LoadLimit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Center(
          child:Text("load limit"),
        ),
      )
    );
  }
}
