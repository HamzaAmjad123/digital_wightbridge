
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
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 12.0,horizontal: 5.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 5.0,
        shadowColor: bgColor,
        child: Container(

          decoration: BoxDecoration(

          ),
          width: MediaQuery.of(context).size.width /2.4,
          padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(truckUrl!,width: 50.0),
              Text(truckName!,style: wheelStyle,)
            ],
          ),
        ),
      ),
    );
  }
}
