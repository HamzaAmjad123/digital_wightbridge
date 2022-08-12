import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_weighbridge/configs/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../helper_services/custom_snacbar.dart';
import '../../helper_widgets/custom_button.dart';
import '../../helper_widgets/custom_textfield.dart';
import '../../models/user_model.dart';
import '../home/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  UserModel usermodels = UserModel();
  final box=GetStorage();
  File? imageFile;
  bool uploading = false;
  String imageUrl = "";
  bool _show = false;

  @override
  initState(){
    super.initState();
    getUser();
  }
  Future<void> getUser()async{
    usermodels= UserModel.fromJson(box.read('user'));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameCont=new TextEditingController();
    TextEditingController phoneCont=new TextEditingController();
    return Scaffold(
      bottomSheet: _showBottomSheet(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 250,
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/8,left:MediaQuery.of(context).size.width/3 ),
                        child: Stack(children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child: usermodels.imgUrl == null ? Image.asset(
                              "assets/images/profile_picture.png", fit: BoxFit
                                .cover,) :imageUrl==""?Image.network(usermodels.imgUrl!,fit: BoxFit.fill,):Image.network(imageUrl,fit: BoxFit.fill,),
                          ),
                          Positioned(
                            top: 65,
                            left: 70,
                            child: GestureDetector(
                              onTap: () {
                                _show = true;
                                setState(() {});
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:  Color(0xFFF5F6F9),
                                ),
                                child: Icon(Icons.camera_alt_outlined,
                                  color: Colors.green,),
                              ),
                            ),
                          ),
                        ],)
                    ),

                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.only(
                        //bottomLeft: Radius.circular(50),
                      )),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    headerText: "UserName",
                    hintText: usermodels.userName,
                    inputAction: TextInputAction.next,
                    isSelected: true,
                    controller: nameCont,
                  ),
                  CustomTextField(
                    headerText: "PhoneNumber",
                    hintText: usermodels.phoneNumber,
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                    isSelected: true,
                    controller: phoneCont,
                  ),
                  Text("Email",style: TextStyle(color: Colors.black54,fontSize: 16.0,height: 1.5),),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
                    height: 45.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: blackColor),
                        borderRadius: BorderRadius.circular(12.0),),
                    child: Text(
                      usermodels.email!,style: TextStyle(color: blackColor,fontSize: 16.0,fontWeight: FontWeight.w500,),
                    ),
                  ),
                  CustomButton(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
                    buttonColor: bgColor,
                    fontWeight: FontWeight.bold,
                    onTap: () async {
                        await updateInfo();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    },
                    text: "Save",
                    fontSize: 18.0,
                    verticalMargin: 15.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;

    pickedFile = await imagePicker.pickImage(source: source);
    imageFile = File(pickedFile!.path);

    if (imageFile != null) {
      try {
        uploading = true;
        imageUrl = await uploadFile(imageFile!);
        setState(() {});
        return imageUrl;
      } catch (e) {
        CustomSnackBar.showSnackBar(context: context, message: e.toString());
      }
    } else {
      CustomSnackBar.failedSnackBar(
          context: context, message: "Please select an image file");
    }
  }

  Future<String> uploadFile(File image) async {
    String fileName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask.then((TaskSnapshot storageTaskSnapshot) {
      return storageTaskSnapshot.ref.getDownloadURL();
    }, onError: (e) {
      throw Exception(e.toString());
    });
  }

  updateInfo() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
   await firebaseFirestore.collection("users").doc(usermodels.uid).update(
        {
          "userName": usermodels.userName,
          "imgUrl" : imageUrl==""?usermodels.imgUrl:imageUrl,
        }).then((_){
      print("success!");
    });

    //for email
    //for password
    //for phone number
    //for picture
  }
  Widget _showBottomSheet()
  {
    if(_show)
    {
      return BottomSheet(
        onClosing: () {

        },
        builder: (context) {
          return Container(
            height: 120,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(onPressed: (){
                    _show=false;
                    setState(() {});
                    getImage(ImageSource.gallery);
                    // setState(() {});
                  }, label: Text("Choose From Gallery",style: TextStyle(color: Colors.black),),icon: Icon(Icons.photo,color: Colors.black,),),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  TextButton.icon(onPressed: (){
                    _show=false;
                    setState(() {});
                    getImage(ImageSource.camera);
                    // setState(() {});
                  }, label: Text("Open Camera",style: TextStyle(color: Colors.black)),icon: Icon(Icons.camera_alt_sharp,color: Colors.black),),
                ],
              ),
            )
          );
        },
      );
    }
    else{
      print(_show);
      return Text("");
    }
  }
}