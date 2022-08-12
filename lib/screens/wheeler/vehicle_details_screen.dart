import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_weighbridge/configs/colors.dart';
import 'package:digital_weighbridge/configs/text_styles.dart';
import 'package:digital_weighbridge/helper_widgets/custom_button.dart';
import 'package:digital_weighbridge/helper_widgets/custom_textfield.dart';
import 'package:digital_weighbridge/screens/qr_and_printer/printer_screen.dart';
import 'package:flutter/material.dart';

import '../../helper_services/custom_loader.dart';
import '../../helper_services/custom_snacbar.dart';
import '../../helper_services/navigation_services.dart';
import '../../models/order_model.dart';
class VehicleDetailsScreen extends StatefulWidget {
  final  String? vehicalType;
  VehicleDetailsScreen({this.vehicalType});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  TextEditingController nameCont=new TextEditingController();
  List<Order> order_list=[];
  int slectedIndex=-1;
  String selectednoPlate = "Select noPlate";
  String weightType="Select Weight Type";
  List<String> weightTypeList=["Iron","Wood","Plastic","Steel","Copper"];
  List<String> vehicalNoPlate = [];
  Order order=new Order();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) =>  getData());
  }
  Future getData()async{
    await getVehicels("orders");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4.0,
                  color: whiteColor,
                  shadowColor: bgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.vehicalType!+"  Info",
                          style: wheelStyle,
                        ),
                        CustomTextField(
                          hintText: "Name",
                          inputAction: TextInputAction.next,
                          controller: nameCont,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.0),
                          height: 45.0,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.0, color: bgColor),
                          ),
                          child: DropdownButton(
                              style: TextStyle(
                                  height: 2.3,
                                  color: blackColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                              isExpanded: true,
                              underline: SizedBox(),
                              hint: Text(selectednoPlate),
                              items: vehicalNoPlate.map((item) {
                                return DropdownMenuItem(
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        height: 2.3,
                                        color: blackColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                selectednoPlate = value!;
                                CustomLoader.showLoader(context: context);
                                getOrderDetails(selectednoPlate);
                                CustomLoader.hideLoader(context);
                                setState(() {});
                              }),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.0),
                          height: 45.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 2.0, color: bgColor),
                            ),
                          ),
                          child: Text(widget.vehicalType!,
                            style: TextStyle(
                                height: 2.3,
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                          ),),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total Weight",
                                style: TextStyle(
                                    height: 2.3,
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: slectedIndex<0?
                                    "Weight Type:":"Weight type:"+" ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        height: 2.3,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                    children: [
                                      TextSpan(
                                          text: slectedIndex<0?"wood":order.wighttype!,
                                          style: TextStyle(
                                            color: bgColor,
                                            height: 2.3,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 3.0),
                                  height: 45.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(width: 2.0, color: bgColor),
                                    ),
                                  ),
                                  child: Text(slectedIndex<0?
                                  "0000kg":order.bridgeWieght!+"kg",
                                    style: TextStyle(
                                        height: 2.3,
                                        color: Colors.black87,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 3.0),
                                height: 45.0,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 2.0, color: bgColor),
                                  ),
                                ),
                                child: DropdownButton(
                                    style: TextStyle(
                                        height: 2.3,
                                        color: blackColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500),
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    hint: Text(weightType),
                                    items: weightTypeList.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                              height: 2.3,
                                              color: blackColor,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        value: item,
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      weightType = value!;
                                      setState(() {});
                                    }),
                              ),
                            ),

                          ],
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.0),
                            height: 45.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 2.0, color: bgColor),
                              ),
                            ),
                            child: Text(slectedIndex<0?
                            "Product Weight":getWeight()+"kg",
                              style: TextStyle(
                                  height: 2.3,
                                  color: Colors.black87,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            )),
                        SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomButton(
                                verticalMargin: 15.0,
                                text: "Submit",
                                onTap: ()async{
                                },
                              ),
                            ), Expanded(
                              child: CustomButton(
                                verticalMargin: 15.0,
                                text: "Print",
                                onTap: ()async{
                                bool res=  await changeStatus(order.id!);
                                  if(res){
                                    NavigationServices.goNextAndKeepHistory(context: context, widget: PrinterScreen(order: order));
                                    setState((){});
                                  }

                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
  // Future<void> addVehical() {
  //   CollectionReference vehical = FirebaseFirestore.instance.collection("orders");
  //   // Calling the collection to add a new user
  //   return vehical
  //   //adding to firebase collection
  //       .add({
  //
  //     //Data added in the form of a dictionary into the document.
  //     'name':'Pick Up',
  //     'noPlate':'ABC1111',
  //     'truckType':"4wheeler",
  //     'bridge wieght':"1800",
  //     "status":"active",
  //     "wighet type":"cooper",
  //     'vehicleWeight':"300",
  //   })
  //
  //       .then((value) => print("Order Added Succesfully"))
  //       .catchError((error) => print("Order couldn't be added."));
  // }





  Future getVehicels(String collection) async {
    List temp= [];
    List temp2=[];
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection(collection);
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    // temp = await querySnapshot.docs.map((doc){
    //   print(doc.id);
    //   doc.data();}).toList();
   temp=await querySnapshot.docs.map((doc) => doc.data()).toList();
   temp2=await querySnapshot.docs.map((doc) => doc.id).toList();
   print(temp2);
    for(int i=0;i<temp.length;i++){
      if(temp[i]['status']=="active"){
        order_list.add(Order(
          id: temp2[i],
          name: temp[i]["name"],
          noPlate: temp[i]["noPlate"],
          truckType: temp[i]["truckType"],
          status: temp[i]["status"],
          bridgeWieght: temp[i]["bridge wieght"],
          vehicleWeight: temp[i]["vehicleWeight"],
          wighttype: temp[i]["wighet type"]
        ));
        vehicalNoPlate.add(temp[i]['noPlate']);
      }
    }
    setState(() {});
  }

  void getOrderDetails(String selectednoPlate) {
    print(selectednoPlate);
    print(order_list);
    for(int i=0;i<order_list.length;i++){
      if(selectednoPlate==order_list[i].noPlate){
        slectedIndex=i;
      }
    }
    if(slectedIndex>=0){
     order=order_list[slectedIndex];
     setState(() {});
    }else{
      CustomSnackBar.failedSnackBar(context: context, message: "there is no record");
    }
  }

  getWeight() {
    return "12000";
  }

  Future<bool> changeStatus(String id)async {
    print(id);
    print(id);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection("orders")
        .doc(id)
        .update({
      "status": "complete",
    });
    return true;
  }



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
}
