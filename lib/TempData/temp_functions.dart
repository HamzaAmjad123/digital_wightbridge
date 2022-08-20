// Future<void> addVehical() {
//   CollectionReference vehical = FirebaseFirestore.instance.collection("12Wheeler");
//   // Calling the collection to add a new user
//   return vehical
//   //adding to firebase collection
//       .add({
//
//     //Data added in the form of a dictionary into the document.
//     'name':'Truck',
//     'totalCapacity': "42000",
//     'vehicleWeight':"31000",
//   })
//
//       .then((value) => print("Order Added Succesfully"))
//       .catchError((error) => print("Order couldn't be added."));
// }
//
// Future<bool> changeStatus(String id)async {
//   print(id);
//   print(id);
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   await firebaseFirestore.collection("orders")
//       .doc(id)
//       .update({
//     "status": "complete",
//   });
//   return true;
// }

// Future getVehicels(String collection) async {
//   List temp= [];
//   List temp2=[];
//   CollectionReference _collectionRef =
//   FirebaseFirestore.instance.collection(collection);
//   // Get docs from collection reference
//   QuerySnapshot querySnapshot = await _collectionRef.get();
//   // Get data from docs and convert map to List
//   // temp = await querySnapshot.docs.map((doc){
//   //   print(doc.id);
//   //   doc.data();}).toList();
//  temp=await querySnapshot.docs.map((doc) => doc.data()).toList();
//  temp2=await querySnapshot.docs.map((doc) => doc.id).toList();
//  print(temp2);
//   for(int i=0;i<temp.length;i++){
//     if(temp[i]['status']=="active"){
//       order_list.add(OrderModel(
//         id: temp2[i],
//         name: temp[i]["name"],
//         noPlate: temp[i]["noPlate"],
//         truckType: temp[i]["truckType"],
//         status: temp[i]["status"],
//         bridgeWieght: temp[i]["bridge wieght"],
//         vehicleWeight: temp[i]["vehicleWeight"],
//         wighttype: temp[i]["wighet type"]
//       ));
//       vehicalNoPlate.add(temp[i]['noPlate']);
//     }
//   }
//   setState(() {});
// }
//
// void getOrderDetails(String selectednoPlate) {
//   print(selectednoPlate);
//   print(order_list);
//   for(int i=0;i<order_list.length;i++){
//     if(selectednoPlate==order_list[i].noPlate){
//       slectedIndex=i;
//     }
//   }
//   if(slectedIndex>=0){
//    order=order_list[slectedIndex];
//    setState(() {});
//   }else{
//     CustomSnackBar.failedSnackBar(context: context, message: "there is no record");
//   }
// }



// Future getData(String collection) async {
//   List orders_list= [];
//   CollectionReference _collectionRef =
//   FirebaseFirestore.instance.collection(collection);
//   // Get docs from collection reference
//   QuerySnapshot querySnapshot = await _collectionRef.get();
//   // Get data from docs and convert map to List
//  orders_list = await querySnapshot.docs.map((doc) => doc.data()).toList();
//   /*return users_list.toList();*/
// }




// Future<bool> userExists(String username) async =>
//     (await FirebaseFirestore.instance.collection("4Wheeler").where("noPlate", isEqualTo: username).get()
//         .then((value) => value.size > 0 ? true : false));