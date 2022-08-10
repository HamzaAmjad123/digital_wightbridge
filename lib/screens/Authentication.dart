

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';

class Authentication{
  User? user = FirebaseAuth.instance.currentUser;
  UserModel usermodels = UserModel();
  final box = GetStorage();

    Future<UserModel>getUser()async{
      print("call iiiiiiiiiiiiiit");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        this.usermodels = UserModel.fromJson(value.data());
      });
      await box.write('user', usermodels.toMap());
      print("iiiiiiiiiiiiiiiiiiiddddddd");
      print(usermodels.uid);
      return usermodels;
    }

  Future<void> EditProfile()async{

  }
}