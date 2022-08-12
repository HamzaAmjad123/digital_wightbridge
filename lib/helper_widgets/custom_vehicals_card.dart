
import 'package:flutter/material.dart';

import '../configs/colors.dart';
import '../configs/text_styles.dart';

class CustomVehiclesCard extends StatelessWidget {
  final String? truckUrl;
  final String? truckName;
  final Function()? onTap;
  const CustomVehiclesCard({ this.truckUrl="", this.truckName="", this.onTap});
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: onTap,
      child: SingleChildScrollView(
        child: Card(

          margin: EdgeInsets.symmetric(vertical: 12.0,horizontal: 18.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          elevation: 5.0,
          shadowColor: bgColor,
          child: Container(

            decoration: BoxDecoration(

            ),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(truckUrl!,width: 50.0),
               Container(
                 margin: EdgeInsets.symmetric(horizontal: 12.0),
                 height: MediaQuery.of(context).size.height/18,
                 width: 2.0,
                 color: blackColor,
               ),
                Text(truckName!,style: wheelStyle,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
