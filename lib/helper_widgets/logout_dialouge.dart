import 'package:digital_weighbridge/configs/colors.dart';
import 'package:digital_weighbridge/helper_services/navigation_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../helper_services/custom_snacbar.dart';
import '../screens/Auth/login_screen.dart';

class SignOutConfirmationDialog extends StatelessWidget {
  final bool isSetting;
  final box = GetStorage();
  SignOutConfirmationDialog({this.isSetting = false});

  // final UserRepository _userRepository = UserRepository();
  // final Rx<User> currentUser = Get.find<AuthService>().user;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          child: Text('Confirm Logout Your Account', style: TextStyle(fontSize: 12,color: bgColor), textAlign: TextAlign.center),
        ),
        Divider(height: 0, color: bgColor),
        Row(children: [
          Expanded(child: InkWell(
            onTap: () async {
              Navigator.pop(context);
              await box.remove('user');
              bool res=await _signOut();

              if(res){
                CustomSnackBar.showSnackBar(context: context, message: "LogOut Succesfully");
                NavigationServices.goNextAndKeepHistory(
                    context: context, widget: LoginScreen());
                // await Get.find<AuthService>().removeCurrentUser();
                // Get.showSnackbar(Ui.ErrorSnackBar(message: 'User has been deleted successfully'));
                // Get.find<RootController>().changePage(0);
              }
            },
            child: Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),color: bgColor),
              child: Text('YES' ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            ),
          )),
          Expanded(child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
                child: Text('NO',style: TextStyle(color: Colors.black))),
          ),
          ),
        ]),
      ]),
    );
  }
  Future<bool> _signOut() async {
    await FirebaseAuth.instance.signOut();
    return true;
  }
}
