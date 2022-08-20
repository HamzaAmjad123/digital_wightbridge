import 'package:digital_weighbridge/helper_services/custom_snacbar.dart';
import 'package:digital_weighbridge/helper_services/navigation_services.dart';
import 'package:digital_weighbridge/helper_widgets/custom_button.dart';
import 'package:digital_weighbridge/screens/Auth/reset_password.dart';
import 'package:digital_weighbridge/screens/Auth/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../configs/colors.dart';
import '../../helper_services/custom_loader.dart';
import '../../helper_widgets/custom_textfield.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Expanded(child: SigInWidget()),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        color: bgColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0)),
                        boxShadow: [
                          BoxShadow(
                            color: bgColor.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 8,
                            // offset: Offset(0, 0),
                          )
                        ]),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 15.0, left: 13.0),
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
                  Spacer(),

                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(right: 15.0, top: 17.0, bottom: 15.0),
                  //   child: InkWell(
                  //     onTap: () {
                  //       NavigationServices.goNextAndKeepHistory(
                  //           context: context, widget: SignUpScreen());
                  //     },
                  //     child: Text(
                  //       "Sign Up",
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 25.0,
                  //           fontWeight: FontWeight.w800),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SigInWidget extends StatefulWidget {
  const SigInWidget({Key? key}) : super(key: key);

  @override
  State<SigInWidget> createState() => _SigInWidgetState();
}

class _SigInWidgetState extends State<SigInWidget> {
  TextEditingController _emailCont = TextEditingController();
  TextEditingController _passwordCont = TextEditingController();
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  String selectedRadio = '';

  bool isObscure = true;

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 0.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(top: 90.0, right: 13.0),
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
          // SizedBox(
          //   height: MediaQuery.of(context).size.height / 18.5,
          // ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
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
                    prefixIcon: Icons.email,
                    hintText: "salman@gmail.com",
                    controller: _emailCont,
                    focusNode: _emailFocus,
                  ),
                  CustomTextField(
                    prefixIcon: Icons.key,
                    hintText: "*****",
                    inputType: TextInputType.visiblePassword,
                    obscureText: isObscure,
                    controller: _passwordCont,
                    focusNode: _passwordFocus,
                    suffixIcon: isObscure == true
                        ? Icons.visibility
                        : Icons.visibility_off,
                    sufOnTap: () {
                      isObscure = !isObscure;
                      setState(() {});
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      child: Text(
                        "forgot Password?",
                        style: TextStyle(
                            color: bgColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      onPressed: () {
                        NavigationServices.goNextAndDoNotKeepHistory(
                            context: context, widget: ResetPassword());
                      },
                    ),
                  ),
                  CustomButton(
                    width: MediaQuery.of(context).size.width * 0.9,
                    buttonColor: bgColor,
                    fontWeight: FontWeight.bold,
                    onTap: () {
                      bool res= _validateLogin();
                      if(res) {
                        CustomLoader.showLoader(context: context);
                        signIn(
                          _emailCont.text,
                          _passwordCont.text,
                        );
                        CustomLoader.hideLoader(context);
                      } },
                    text: "Login",
                    fontSize: 18.0,
                    verticalMargin: 0.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: RichText(
                      text: TextSpan(
                          text: 'Don\'t Have an acount?',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal),
                          children: [
                            TextSpan(
                                text: 'Signup',
                                style: TextStyle(
                                  color: bgColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    NavigationServices.goNextAndKeepHistory(
                                        context: context, widget: SignUpScreen());
                                  }),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
 bool _validateLogin(){
    if(_emailCont.text.isEmpty || !_validateEmail(_emailCont.text)){
      CustomSnackBar.failedSnackBar(context: context, message: "Enter valid email address");
      _emailFocus.requestFocus();
      return false;
    }
    else if(_passwordCont.text.length<6){
      CustomSnackBar.failedSnackBar(context: context, message: "Password must be more then 6 character");
      _passwordFocus.requestFocus();
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
  Future<void> signIn(String email, String password) async {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
        CustomSnackBar.showSnackBar(context: context, message: "Login Successfully"),
      NavigationServices.goNextAndDoNotKeepHistory(
      context: context, widget: HomeScreen())
      })
          .catchError((e) {
        // Fluttertoast.showToast(msg: e!.message);
        CustomSnackBar.showSnackBar(context: context, message:e!.message);
      });
    }


}
