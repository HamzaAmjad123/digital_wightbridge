/*
 * File name: custom_drawer.dart
 * Last modified: 2022.02.11 at 02:22:41
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_weighbridge/helper_services/custom_snacbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../configs/colors.dart';
import '../../helper_services/navigation_services.dart';
import '../../helper_widgets/animated_dialog.dart';
import '../../helper_widgets/deletion_dialouge.dart';
import '../../helper_widgets/drawer_widget.dart';
import '../../models/user_model.dart';
import '../Auth/login_screen.dart';
import '../profile.dart';
import 'home_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    UserModel usermodels = UserModel();
    return Drawer(
      child: ListView(children: [
        Container(
          padding: EdgeInsets.only(top:10, right:15,left: 15),
          decoration: BoxDecoration(
            color: bgColor,
            // color: Theme.of(context).hintColor.withOpacity(0.1),
          ),
          child: Text("Welcome",
              style: Get.textTheme.headline5!.merge(
                  TextStyle(fontWeight: FontWeight.normal,fontSize: 20))),
        ),
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: bgColor,
          ),
          accountName: Text("asda ali",
            //usermodels.userName!,
            style: TextStyle(color: Colors.black),
          ),
          accountEmail: Text("asda ali@gmail.com",
           // usermodels.email!,
            style: TextStyle(color: Colors.black),
          ),
          currentAccountPicture: Stack(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  child: CachedNetworkImage(
                    height: 80,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: "https://picsum.photos/250?image=9",
                    placeholder: (context, url) => Image.asset(
                      "assets/images/place_holder.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 80,
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error_outline),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        DrawerLinkWidget(
          icon: Icons.home_outlined,
          text: "Home",
          onTap: () {
            Navigator.of(context).pop();
            NavigationServices.goNextAndKeepHistory(context: context, widget: HomeScreen());
            setState((){});
            setState(() {});
          },
        ),

        DrawerLinkWidget(
          icon: Icons.folder_special_outlined,
          text: "Profile",
          onTap: () {
            Navigator.of(context).pop();
            NavigationServices.goNextAndKeepHistory(context: context, widget: ProfileScreen());
            setState((){});
          },
        ),

        DrawerLinkWidget(
          icon: Icons.chat_outlined,
          text: "Default",
          onTap: () async {
            Get.back();
          },
        ),
        ListTile(
          dense: true,
          title: Text(
            "Application preferences".tr,
            style: Get.textTheme.caption,
          ),
          trailing: Icon(
            Icons.remove,
            color: Get.theme.focusColor.withOpacity(0.3),
          ),
        ),
        DrawerLinkWidget(
          icon: Icons.account_balance_wallet_outlined,
          text: "About Us",
          onTap: () async {

          },
        ),
        DrawerLinkWidget(
          icon: Icons.person_outline,
          text: "Privacy Policy",
          onTap: () async {
            Get.back();
          },
        ),

        ListTile(
          dense: true,
          title: Text(
            "Account & Settings",
            style: Get.textTheme.caption,
          ),
          trailing: Icon(
            Icons.remove,
            color: Get.theme.focusColor.withOpacity(0.3),
          ),
        ),
        DrawerLinkWidget(
          icon: Icons.settings_outlined,
          text: "Settings",
          onTap: () async {

          },
        ),
        DrawerLinkWidget(
          icon: Icons.logout,
          text: "Logout",
          onTap: () {
            Navigator.of(context).pop();
            showAnimatedDialog(context, SignOutConfirmationDialog(), isFlip: true);
          },
        ),
      ]),
    );
  }

}
