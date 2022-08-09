

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class Authentication{
  User? user = FirebaseAuth.instance.currentUser;
  UserModel usermodels = UserModel();

    Future<UserModel>getUser()async{
      print("call it");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        this.usermodels = UserModel.fromJson(value.data());
      });
      return usermodels;
    }

  Future<void> EditProfile()async{

  }
}