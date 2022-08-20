

import 'package:digital_weighbridge/screens/Auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../configs/colors.dart';
import '../../helper_services/custom_snacbar.dart';
import '../../helper_services/navigation_services.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController? _resetemail=TextEditingController();
  bool _validate = false;
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
           children: [
             Stack(
               children: [
                 Container(
                   width: MediaQuery.of(context).size.width,
                   height: 200,
                   decoration: BoxDecoration(
                       color: bgColor,
                       borderRadius: BorderRadius.only(
                         bottomLeft: Radius.circular(50),
                       )),
                 ),
                 Center(
                   child: Column(
                     children: [
                       Container(
                           margin: EdgeInsets.only(top: 80),
                           child: Text(
                             "Digital WeightBridge",
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 20,
                               color: Colors.white,
                             ),
                           )),
                       Container(
                           margin: EdgeInsets.only(top: 10),
                           child: Text(
                             "Wellcome To The Best Digital Weight System.",
                             style: TextStyle(
                               fontWeight: FontWeight.normal,
                               fontSize: 16,
                               color: Colors.white,
                             ),
                           )),
                     ],
                   ),
                 ),
                 Center(
                   child: Container(
                     margin: EdgeInsets.only(top: 145),
                     child: Image.asset(
                       "assets/images/logo.jpeg",
                       height: 80.0,
                       width: 90.0,
                     ),
                   ),
                 ),
               ],
             ),
             Container(
                 margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                 child: Text(
                   "Enter Your Email Adress so we sent Verfication Email To Your Email Address, After Verification Complete You can Reset Your Pasword",
                   style: TextStyle(
                     fontWeight: FontWeight.normal,
                     fontSize: 16,
                     color: Colors.black,
                   ),
                   textAlign: TextAlign.justify,
                 )),

             Padding(
               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
               child: Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                       height: 50,
                       margin: EdgeInsets.symmetric(horizontal: 10),
                       child: TextField(
                         textInputAction: TextInputAction.done,
                         keyboardType: TextInputType.emailAddress,
                         obscureText: false,
                         decoration: InputDecoration(
                             suffixIcon: Icon(Icons.mail,size: 22,color: Colors.grey,),
                             hintText: 'abc@gmail.com',
                             label: Text("Enter Email"),
                             filled: true,
                             errorText: _validate ? 'Emailaddress Can\'t Be Empty' : null,
                             hintStyle: TextStyle(color: Colors.grey,fontSize: 18),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10),
                                 borderSide: BorderSide(
                                   color: Colors.blueGrey,
                                 )
                             )
                         ),
                         controller: _resetemail,
                       ),
                     ),
                     Container(
                       height: 35,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15),
                       ),
                       margin: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                       child: ElevatedButton(
                         onPressed: (){
                           setState(() {
                             _resetemail!.text.isEmpty ? _validate = true : _validate = false;
                           });
                           resetPassword(_resetemail!.text);
                         },
                         style: ElevatedButton.styleFrom(
                           primary: Color(0xFF811717),
                         ),
                         child: Text(
                           "Reset Password",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 14,
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ),
           ],
          ),
        ),
      ),
    );
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      NavigationServices.goNextAndDoNotKeepHistory(
          context: context, widget: LoginScreen());
     CustomSnackBar.showSnackBar(context: context, message: "verification mail sent:on your enter email adress");
    } catch (e) {
      print(e);
      CustomSnackBar.failedSnackBar(context: context, message:e.toString());
    }
  }

}