import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_weighbridge/configs/colors.dart';
import 'package:digital_weighbridge/configs/text_styles.dart';
import 'package:digital_weighbridge/helper_widgets/custom_button.dart';
import 'package:digital_weighbridge/helper_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../models/truckmodel.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final  String? vehicalType;
  VehicleDetailsScreen({this.vehicalType});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance
        .addPostFrameCallback((_) =>  getData(widget.vehicalType!));
  }
  String weightType="Select Weight Type";
  List<String> weightTypeList=["Iron","Wood","Plastic","Steel","Copper"];
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
                    ),
                    CustomTextField(
                      hintText: "Number Plate",
                      inputAction: TextInputAction.next,
                    ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 3.0),
                    //   height: 45.0,
                    //   decoration: BoxDecoration(
                    //     border: Border(
                    //       bottom: BorderSide(width: 2.0, color: bgColor),
                    //     ),
                    //   ),
                    //   child: DropdownButton(
                    //       style: TextStyle(
                    //           height: 2.3,
                    //           color: blackColor,
                    //           fontSize: 16.0,
                    //           fontWeight: FontWeight.w500),
                    //       isExpanded: true,
                    //       underline: SizedBox(),
                    //       hint: Text(selectedTruck),
                    //       items: truckTypeList.map((item) {
                    //         return DropdownMenuItem(
                    //           child: Text(
                    //             item,
                    //             style: TextStyle(
                    //                 height: 2.3,
                    //                 color: blackColor,
                    //                 fontSize: 16.0,
                    //                 fontWeight: FontWeight.w500),
                    //           ),
                    //           value: item,
                    //         );
                    //       }).toList(),
                    //       onChanged: (String? value) {
                    //         selectedTruck = value!;
                    //         setState(() {});
                    //       }),
                    // ),
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
                    Text(
                      "Total Weight",
                      style: TextStyle(
                          height: 2.3,
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
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
                           child: Text(
                             "256kg",
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
                        child: Text(
                          "Product Weight",
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
                              await addOrders();
                            },
                          ),
                        ), Expanded(
                          child: CustomButton(
                            verticalMargin: 15.0,
                            text: "Print",
                            onTap: (){
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
  Future<void> addOrders() {
    CollectionReference students = FirebaseFirestore.instance.collection('4Wheeler');
    // Calling the collection to add a new user
    return students
    //adding to firebase collection
        .add({
      //Data added in the form of a dictionary into the document.
      'name': "Loader Rikshaw",
      'Load Limit':'800kg',
      'noPlate':'ABC1234',
      'truckType':"4wheeler",
      'Total_wieght': "1000Kg",
      'vehi?cleWeight':"200kg",
    })

        .then((value) => print("Order Added Succesfully"))
        .catchError((error) => print("Order couldn't be added."));
  }
  Future/*<List>*/ getData(String collection) async {
    print("calling");
    List orders_list= [];
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection(collection);
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
   orders_list = await querySnapshot.docs.map((doc) => doc.data()).toList();
    print(orders_list.length);
    print(orders_list);
    print("calling itt");
    /*return users_list.toList();*/
  }
}
