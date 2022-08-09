class UserModel {
  String? uid;
  String? userName;
  String? email;
  String? imgUrl;
  String? password;
  String? confirmPassword;
  String? phoneNumber;

  UserModel(
      {this.uid,
        this.imgUrl,
      this.userName,
      this.email,
      this.password,
      this.confirmPassword,
      this.phoneNumber});

  factory UserModel.fromJson(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      imgUrl: map['imgUrl'],
      password: map['password'],
      confirmPassword: map['name'],
      phoneNumber: map['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'imgUrl': imgUrl,
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'confirmPassword': confirmPassword,
      'password': password,

    };
  }
}
