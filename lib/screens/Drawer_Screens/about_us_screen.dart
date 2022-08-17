import 'package:digital_weighbridge/configs/colors.dart';
import 'package:flutter/material.dart';

import '../../configs/text_styles.dart';


class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("About Us",style: aboutStyle,)),
            Card(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)
              ),
              elevation: 10.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/user_icon.png",height: 100.0,),
                    SizedBox(height: 12.0,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 22.0),
                      alignment: Alignment.center,
                      width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: blackColor
                          )
                        ),
                        child: Text("Salman",style: wheelStyle,)),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12.0),
                        padding: EdgeInsets.symmetric(horizontal: 22.0),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: blackColor
                            )
                        ),
                        child: Text("salman@gmail.com",style: wheelStyle,)),
                  ],
                ),
              ),
            ), Card(
              margin: EdgeInsets.symmetric(vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)
              ),
              elevation: 10.0,
              child: Container(

                padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/user_icon.png",height: 100.0,),
                    SizedBox(height: 12.0,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 22.0),
                      alignment: Alignment.center,
                      width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: blackColor
                          )
                        ),
                        child: Text("Talha",style: wheelStyle,)),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12.0),
                        padding: EdgeInsets.symmetric(horizontal: 22.0),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: blackColor
                            )
                        ),
                        child: Text("talha@gmail.com",style: wheelStyle,)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
