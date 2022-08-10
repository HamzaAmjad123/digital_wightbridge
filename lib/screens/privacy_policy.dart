
import 'package:digital_weighbridge/configs/colors.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text("Privacy Ploicy",style:TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 18
        ),
        ),
        leading: IconButton(
          icon:Icon( Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              Container(
                child: Text(""),
              )
            ],
          ),
        ),
      ),
    );
  }
}
