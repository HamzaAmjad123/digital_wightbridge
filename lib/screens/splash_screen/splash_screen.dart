import 'dart:async';
import 'package:digital_weighbridge/configs/colors.dart';
import 'package:digital_weighbridge/helper_services/navigation_services.dart';
import 'package:digital_weighbridge/screens/Auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    Timer(Duration(seconds:5), () =>
    NavigationServices.goNextAndDoNotKeepHistory(context: context, widget: LoginScreen())
    );
    setState((){});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        child: Image.asset("assets/images/LOGO.gif"),
        // child: Image.asset("assets/images/splash_image.gif"),
      ),
    );
  }
}
