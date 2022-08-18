import 'package:digital_weighbridge/configs/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double? width;
  final double horizontalMargin;
  final double verticalMargin;
  final String? text;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Function()? onTap;

  CustomButton({
    this.height = 45.0,
    this.width,
    this.horizontalMargin = 8.0,
    this.verticalMargin = 8.0,
    this.text="",
    this.buttonColor=bgColor,
    this.textColor=whiteColor,
    this.fontSize=15.0,
    this.fontWeight=FontWeight.normal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: bgColor.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin, vertical: verticalMargin),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          alignment: Alignment.center,
         primary: buttonColor
        ),
        onPressed: onTap,
        child: Text(text!,style: TextStyle(color: textColor,fontWeight: fontWeight,fontSize: fontSize),),
      ),
    );
  }
}
