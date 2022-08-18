import 'package:digital_weighbridge/configs/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? headerText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final bool obscureText;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function()? preOnTap;
  final Function()? sufOnTap;
  final FocusNode? focusNode;
  final bool isSelected;
  CustomTextField({
    this.headerText,
    this.controller,
    this.inputType,
    this.inputAction,
    this.onChange,
    this.onSubmit,
    this.obscureText = false,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.preOnTap,
    this.sufOnTap,
    this.focusNode, this.isSelected=false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerText == null ? SizedBox() : Text(headerText!,style: TextStyle(color: Colors.black54,fontSize: 16.0,),),
        Container(

          margin: EdgeInsets.symmetric(vertical: isSelected==true?8.0:0.0),
          height: 45.0,
          child: TextField(
            cursorColor: blackColor,
            cursorHeight: 30.0,
            style: TextStyle(height: 2.3,color: blackColor,fontSize: 16.0,fontWeight: FontWeight.w500,),
            controller: controller,
            keyboardType: inputType,
            textInputAction: inputAction,
            obscureText: obscureText,
            focusNode: focusNode,
            onChanged: onChange,
            onSubmitted: onSubmit,
            decoration: InputDecoration(
                hintText: hintText,
                labelText: labelText,
                contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 8.0),
                enabledBorder: isSelected==false?UnderlineInputBorder(
                  borderSide: BorderSide(color: bgColor,width: 2.0),
                ):OutlineInputBorder(borderRadius: BorderRadius.circular(12.0,)),
                focusedBorder: isSelected==false?UnderlineInputBorder(
                  borderSide: BorderSide(color: bgColor,width: 2.0),
                ):OutlineInputBorder(borderRadius: BorderRadius.circular(12.0,)),
                suffixIcon: suffixIcon == null
                    ? null
                    : IconButton(onPressed: sufOnTap, icon: Icon(suffixIcon,color: bgColor,)),
                prefixIcon: prefixIcon == null
                    ? null
                    : IconButton(onPressed: preOnTap, icon: Icon(prefixIcon))),
          ),
        )
      ],
    );
  }
}
