import 'package:digital_weighbridge/configs/colors.dart';
import 'package:digital_weighbridge/screens/Authentication.dart';
import 'package:flutter/material.dart';
import '../helper_widgets/custom_textfield.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel usermodels = UserModel();
  // late File imageFile;
  bool uploading = false;
  @override
  oninit()async{
    print("on in it");
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async =>  usermodels=await Authentication().getUser());
    print(usermodels.userName);
    print(usermodels.email);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: Center(
                    child: Stack(children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: usermodels.imgUrl==null?Image.asset("assets/images/profile_picture.png",fit: BoxFit.cover,):Image.network(usermodels.imgUrl!),
                      ),
                        Positioned(
                          top: 60,
                          left: 65,
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black87
                              ),
                              child: Icon(Icons.camera_alt_outlined,color: Colors.green,),
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
                    headerText: "userName",
                    hintText: "Name",
                    inputAction: TextInputAction.next,
                  ),
                  CustomTextField(
                    headerText: "Password",
                    hintText: "Name",
                    inputAction: TextInputAction.next,
                  ),
                  CustomTextField(
                    headerText: "PhoneNumber",
                    hintText: "Name",
                    inputAction: TextInputAction.next,
                  ),
                  Text(
                    "Profile Photo",
                    style: TextStyle(
                        height: 2.3,
                        color: Colors.black87,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Future getImage(ImageSource source) async {
  //   ImagePicker imagePicker = ImagePicker();
  //   XFile? pickedFile;
  //
  //   pickedFile = await imagePicker.pickImage(source: source);
  //   imageFile = File(pickedFile.path);
  //
  //   if (imageFile != null) {
  //     try {
  //       uploading = true;
  //       setState((){});
  //       return await uploadFile(imageFile);
  //     } catch (e) {
  //       CustomSnackBar.showSnackBar(context: context, message: e.toString());
  //     }
  //   } else {
  //     CustomSnackBar.failedSnackBar(context: context, message: "Please select an image file");
  //   }
  // }
  // Future<String> uploadFile(File image) async {
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   Reference reference = FirebaseStorage.instance.ref().child(fileName);
  //   UploadTask uploadTask = reference.putFile(image);
  //   return uploadTask.then((TaskSnapshot storageTaskSnapshot) {
  //     return storageTaskSnapshot.ref.getDownloadURL();
  //   }, onError: (e) {
  //     throw Exception(e.toString());
  //   });
  // }

}
