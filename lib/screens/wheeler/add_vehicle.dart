import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_weighbridge/helper_services/custom_snacbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../configs/colors.dart';
import '../../configs/text_styles.dart';
import '../../helper_services/custom_loader.dart';
import '../../helper_services/navigation_services.dart';
import '../../helper_widgets/custom_button.dart';
import '../../helper_widgets/custom_textfield.dart';
import '../../models/order_model.dart';
import '../qr_and_printer/printer_screen.dart';

class AddNewVehicle extends StatefulWidget {
  const AddNewVehicle({Key? key}) : super(key: key);

  @override
  State<AddNewVehicle> createState() => _AddNewVehicleState();
}

class _AddNewVehicleState extends State<AddNewVehicle> {
  TextEditingController nameCont = new TextEditingController();
  TextEditingController numberCont = new TextEditingController();
  String selectedWeightType = "Select Weight Type";
  List<String> weightTypeList = ["Iron", "Wood", "Plastic", "Steel", "Copper"];
  String selectedvehical = "Select Vehical";
  int slectedIndex = -1;
  String? loadOnVehicle;
  String? productWeight;
  final database = FirebaseDatabase.instance.reference();
  List<String> vehicalsList = [
    "4Wheeler",
    "6Wheeler",
    "10Wheeler",
    "12Wheeler"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text("Add New Vehicle",
            style: TextStyle(color: Colors.white, fontSize: 14)),
        leading: IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
                  Navigator.pop(context),
                }),
      ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 7),
                elevation: 4.0,
                color: whiteColor,
                shadowColor: bgColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add New Vecile",
                        style: wheelStyle,
                      ),
                      Text(
                        "Name",
                        style: TextStyle(
                            height: 2.3,
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600),
                      ),
                      CustomTextField(
                        hintText: "Name",
                        inputAction: TextInputAction.next,
                        controller: nameCont,
                        inputType: TextInputType.name,
                      ),
                      Text(
                        "Vehicle Number",
                        style: TextStyle(
                            height: 2.3,
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600),
                      ),
                      CustomTextField(
                        hintText: "ABS4342",
                        inputAction: TextInputAction.done,
                        controller: numberCont,
                        inputType: TextInputType.emailAddress,
                      ),
                      Text(
                        "Select Vehical",
                        style: TextStyle(
                            height: 2.3,
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.0),
                        height: 45.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                            hint: Text(selectedvehical),
                            items: vehicalsList.map((item) {
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
                              selectedvehical = value!;
                              setState(() {});
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Weight",
                              style: TextStyle(
                                  height: 2.3,
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
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
                                    bottom:
                                        BorderSide(width: 2.0, color: bgColor),
                                  ),
                                ),
                                child: Text(
                                  loadOnVehicle == null
                                      ? "0000kg"
                                      : loadOnVehicle! + "kg",
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
                                  bottom:
                                      BorderSide(width: 2.0, color: bgColor),
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
                                  hint: Text(selectedWeightType),
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
                                    selectedWeightType = value!;
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
                            productWeight == null
                                ? "Product Weight"
                                : productWeight! + "kg",
                            style: TextStyle(
                                height: 2.3,
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                          )),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomButton(
                              verticalMargin: 15.0,
                              text: "Get Data",
                              onTap: () async {
                                if (validateNameAndNumber()) {
                                  activateListner();
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: CustomButton(
                              verticalMargin: 15.0,
                              text: "Add Vehicle",
                              onTap: () async {
                                if (validateNameAndNumber()) {
                                  if (loadOnVehicle == null ||
                                      productWeight == null) {
                                    CustomSnackBar.failedSnackBar(
                                        context: context,
                                        message:
                                            "Get Your Weight  From Firebse");
                                  } else if (selectedWeightType ==
                                      "Select Weight Type") {
                                    CustomSnackBar.failedSnackBar(
                                        context: context,
                                        message: "Slect Weight Type First");
                                  } else {
                                    OrderModel order = new OrderModel(
                                      id: "",
                                      name: nameCont.text,
                                      vehicleName: numberCont.text,
                                      vehcileType: selectedvehical,
                                      totalWieght: loadOnVehicle,
                                      vehicleWeight: getWeight().toString(),
                                      productWeight: productWeight,
                                      weightType: selectedWeightType,
                                    );
                                    bool res=await addRecord(order);
                                    if(res){
                                      NavigationServices.goNextAndDoNotKeepHistory(context: context, widget: PrinterScreen(order: order,));
                                    }else{
                                      CustomSnackBar.failedSnackBar(context: context, message: "Save Record Again");
                                    }
                                  }
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
      ),
    );
  }

  validateNameAndNumber() {
    if (nameCont.text.isEmpty) {
      CustomSnackBar.failedSnackBar(
          context: context, message: "Enter Name First");
      return false;
    } else if (nameCont.text.length < 3) {
      CustomSnackBar.failedSnackBar(
          context: context, message: "Enter Valid Name");
      return false;
    } else if (numberCont.text.isEmpty) {
      CustomSnackBar.failedSnackBar(
          context: context, message: "Enter Name First");
      return false;
    } else if (numberCont.text.length < 7) {
      CustomSnackBar.failedSnackBar(
          context: context, message: "Vlid Number Should be 7 characters");
      return false;
    } else if (selectedvehical == "Select Vehical") {
      CustomSnackBar.failedSnackBar(
          context: context, message: "select vehical First");
      return false;
    } else {
      return true;
    }
  }

  activateListner() async {
    CustomLoader.showLoader(context: context);
    await database.child("Total_Weight").onValue.listen((event) {
      final Object? temp = event.snapshot.value;
      loadOnVehicle = temp.toString();
      setState(() {});
    });
    await database.child("Product_Weight").onValue.listen((event) {
      final Object? temp2 = event.snapshot.value;
      productWeight = temp2.toString();
      setState(() {});
    });
    CustomLoader.hideLoader(context);
  }

  getWeight() {
    double temp = double.parse(productWeight!);
    double temp2 = double.parse(loadOnVehicle!);
    return temp2 - temp;
  }
  Future<bool> addRecord(OrderModel order) {
    CollectionReference vehical = FirebaseFirestore.instance.collection("records");
    // Calling the collection to add a new user
    return vehical
    //adding to firebase collection
        .add({
      'name': nameCont.text,
      'vehicleName': numberCont.text,
      'vehcileType': selectedvehical,
      'totalWieght': loadOnVehicle,
      'vehicleWeight': getWeight().toString(),
     ' productWeight': productWeight,
      'weightType': selectedWeightType,
    })
        .then((value) => true)
        .catchError((error) => false);
  }
}
