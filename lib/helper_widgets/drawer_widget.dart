import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/colors.dart';

class DrawerLinkWidget extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Function()? onTap;

  const DrawerLinkWidget({
    this.icon,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            Icon(
              icon,
              color: bgColor,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              width: 1,
              height: 24,
              color: Get.theme.focusColor.withOpacity(0.2),
            ),
            Expanded(
              child: Text(text!, style:TextStyle(fontSize: 14,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
