import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_weighbridge/helper_services/navigation_services.dart';
import 'package:digital_weighbridge/screens/Auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../configs/colors.dart';
import '../../helper_services/custom_loader.dart';
import '../../helper_services/custom_snacbar.dart';
import '../../helper_widgets/custom_button.dart';
import '../../helper_widgets/custom_textfield.dart';
import '../../models/user_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameCont=TextEditingController();
  TextEditingController _emailCont = TextEditingController();
  TextEditingController _passwordCont = TextEditingController();
  TextEditingController _confirmPswdCont=TextEditingController();
  TextEditingController _noCont=TextEditingController();

  FocusNode _nameFocus=FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPswdFocus=FocusNode();
  FocusNode _noFocus=FocusNode();
  String selectedRadio = '';

  bool isObscure=false;
  bool _isObscure=false;

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 13.0),
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                          color: Colors.white,
                          height: 3.0,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(top: 15.0, right: 13.0),
                    height: 35.0,
                    width: 35.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: bgColor,
                        boxShadow: [
                          BoxShadow(
                            color: bgColor.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 7,
                            // offset: Offset(3, 3),
                          )
                        ]),
                  ),
                  Container(
                    height: 70.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                        color: bgColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            bottomLeft: Radius.circular(50.0)),
                        boxShadow: [
                          BoxShadow(
                            color: bgColor.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 8,
                            // offset: Offset(0, 0),
                          )
                        ]),
                  ),
                ],
              ),
              CircleAvatar(
                maxRadius: 80.0,
                backgroundImage: AssetImage("assets/images/logo.jpeg"),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 25.0),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextField(
                        prefixIcon: Icons.person_outline_outlined,
                        hintText: "UserName",
                        controller: _nameCont,
                        focusNode:_nameFocus,
                        inputAction: TextInputAction.next,
                      ),
                      CustomTextField(
                        prefixIcon: Icons.email,
                        hintText: "salman@gmail.com",
                        controller: _emailCont,
                        focusNode: _emailFocus,
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                      ),
                      CustomTextField(
                        // prefixIcon: Icons.key,
                        // hintText: "Password",
                        // inputType: TextInputType.visiblePassword,
                        // obscureText: isObscure,
                        // controller: _passwordCont,
                        // focusNode: _passwordFocus,
                        prefixIcon: Icons.key,
                        hintText: "Password",
                        controller: _passwordCont,
                        focusNode: _passwordFocus,
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        suffixIcon: isObscure==true?Icons.visibility:Icons.visibility_off,
                        sufOnTap: (){
                          isObscure =! isObscure;
                          setState((){});
                        },
                      ),
                      CustomTextField(
                        prefixIcon: Icons.key,
                        hintText: "ConfirmPassword",
                        inputType: TextInputType.visiblePassword,
                        obscureText: _isObscure,
                        controller: _confirmPswdCont,
                        focusNode: _confirmPswdFocus,
                        inputAction: TextInputAction.next,
                        suffixIcon: _isObscure==true?Icons.visibility:Icons.visibility_off,
                        sufOnTap: (){
                          _isObscure =! _isObscure;
                          setState((){});
                        },
                      ),
                      CustomTextField(
                        prefixIcon: Icons.phone,
                        hintText: "Phone Number",
                        controller: _noCont,
                        focusNode: _noFocus,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.number,

                      ),
                      CustomButton(
                        width: MediaQuery.of(context).size.width * 0.9,
                        buttonColor: bgColor,
                        fontWeight: FontWeight.bold,
                        text: "SignUp",
                        fontSize: 18.0,
                        verticalMargin: 18.0,
                        onTap: ()async{
                          bool res=_validateSignUp();
                          if(res){
                            CustomLoader.showLoader(context: context);
                            await _auth
                                .createUserWithEmailAndPassword(email: _emailCont.text, password: _passwordCont.text)
                                .then((value) => {

                              postDetailsToFirestore()
                            })
                                .catchError((e) {
                              CustomSnackBar.showSnackBar(context: context, message: e!.message);
                            });
                            CustomLoader.hideLoader(context);
                          }
                        },
                      ),
                      RichText(
                        text: TextSpan(text: "Already have an account? ",style: TextStyle(color: blackColor,fontSize: 15.0,height: 2.5),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()..onTap=(){
                                    setState((){});
                                    NavigationServices.goNextAndKeepHistory(context: context, widget: LoginScreen());
                                  },
                                  text: "Login",style: TextStyle(color: blackColor,fontSize: 16.0,fontWeight: FontWeight.w800)
                              )
                            ]),
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
  _validateSignUp(){
    if(_nameCont.text.isEmpty){
      CustomSnackBar.failedSnackBar(context: context, message: "Enter name field");
      _nameFocus.requestFocus();
      return false;
    }
  else  if(_emailCont.text.isEmpty || !_validateEmail(_emailCont.text)){
      CustomSnackBar.failedSnackBar(context: context, message: "Enter valid email address");
      _emailFocus.requestFocus();
      return false;
    }
    else if(_passwordCont.text.length<6){
      CustomSnackBar.failedSnackBar(context: context, message: "Password must be more then 6 character");
      _passwordFocus.requestFocus();
      return false;
    }
    else if(_passwordCont.text != _confirmPswdCont.text){
      CustomSnackBar.failedSnackBar(context: context, message: "Password should be match");
      _confirmPswdFocus.requestFocus();
      return false;
    }
    else if(_noCont.text.isEmpty){
      CustomSnackBar.failedSnackBar(context: context, message: "Phone Number Required");
      _noFocus.requestFocus();
      return false;
    }
    else{
      return  true;
    }
  }
  bool _validateEmail(String text) {
    if (text.isEmpty) {
      return false;
    }

    if (RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text)) {
      return true;
    } else {
      return false;
    }
  }
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel usermodles = UserModel();
    usermodles.email=user!.email;
    usermodles.uid=user.uid;
    usermodles.phoneNumber=_noCont.text;
    usermodles.userName=_nameCont.text;

    await firebaseFirestore.collection("users").doc(user.uid).set(usermodles.toMap());
    CustomSnackBar.showSnackBar(context: context, message: "Account Created successfully");
    NavigationServices.goNextAndKeepHistory(context: context, widget: LoginScreen());
  }
}
