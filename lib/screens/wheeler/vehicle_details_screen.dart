import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_weighbridge/configs/colors.dart';
import 'package:digital_weighbridge/configs/text_styles.dart';
import 'package:digital_weighbridge/helper_services/navigation_services.dart';
import 'package:digital_weighbridge/helper_widgets/custom_button.dart';
import 'package:digital_weighbridge/helper_widgets/custom_textfield.dart';
import 'package:digital_weighbridge/screens/qr_and_printer/printer_screen.dart';
import 'package:digital_weighbridge/screens/wheeler/add_vehicle.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../helper_services/custom_loader.dart';
import '../../helper_services/custom_snacbar.dart';
import '../../models/order_model.dart';
import '../../models/truck_model.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final  String? vehicalType;
  VehicleDetailsScreen({this.vehicalType});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  //basic details
  TextEditingController nameCont=new TextEditingController();
  String selectedWeightType="Select Weight Type";
  List<String> weightTypeList=["Iron","Wood","Plastic","Steel","Copper"];
  // need to evaluate again
  int slectedIndex=-1;
  //for slection truck
  List<TruckModel> truck_list=[];
  String selectedTruck = "Select Vehical";
  int? vehicalWeight;
  List<String> vehicalNameList = [];
  TruckModel truck=new TruckModel();
  //for save order

  final database2=FirebaseDatabase.instance.reference();

  String? loadOnVehicle;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => 
        getData(),
    );
  }

  Future getData()async{
    await getVehicels(widget.vehicalType!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          centerTitle: true,
          title: Text("Wheeler Information",style :TextStyle(color: Colors.white,fontSize: 14)),
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
                Align(alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: (){
                        NavigationServices.goNextAndKeepHistory(context: context, widget: AddNewVehicle());
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 35,
                         width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Icon(Icons.add,color: bgColor,),
                          Text("Add New Truck",style: TextStyle(color: bgColor),)
                        ],),
                      ),
                    )),
                Card(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/9),
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
                        Text("Select Vehical",
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
                              hint: Text(selectedTruck),
                              items: vehicalNameList.map((item) {
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
                                selectedTruck = value!;
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
                                  "0000kg":"14000"+"kg",
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
                            child: Text(loadOnVehicle==null?
                            "Product Weight":"${getWeight()}"+"kg",
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
                                text: "Get Data",
                                onTap: ()async{
                               if(selectedTruck=="Select Vehical")
                               {
                                 CustomSnackBar.failedSnackBar(context: context, message: "Select Vehical First");
                               }
                               else{
                                 if(nameCont.text.isEmpty){
                                   CustomSnackBar.failedSnackBar(context: context, message: "Enter Name first!!");
                                 }
                                 else if(nameCont.text.length<3){
                                   CustomSnackBar.failedSnackBar(context: context, message: "Enter Valid Name!!");
                                 }else{
                                   await activateListner();
                                   await getVehicalWieght(selectedTruck);
                                   setState(() {});
                                 }
                               }
                                },
                              ),
                            ), Expanded(
                              child: CustomButton(
                                verticalMargin: 15.0,
                                text: "Save Records",
                                onTap: ()async{
                               if(selectedWeightType=="Select Weight Type"){
                                 CustomSnackBar.failedSnackBar(context: context, message: "Select Weight type");
                               }else{
                                 OrderModel order=new OrderModel(
                                   id: "",
                                   name: nameCont.text,
                                   vehicleName: selectedTruck,
                                   vehcileType: widget.vehicalType,
                                   totalWieght: loadOnVehicle,
                                   vehicleWeight: truck.vehicleWeight,
                                   productWeight: getWeight().toString(),
                                   weightType: selectedWeightType,
                                 );
                                 bool res=await addRecord(order);
                                if(res){
                                  NavigationServices.goNextAndDoNotKeepHistory(context: context, widget: PrinterScreen(order: order,));
                                }else{
                                  CustomSnackBar.failedSnackBar(context: context, message: "Save Record Again");
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
        ));
  }

  Future getVehicels(String collection) async {
    List temp= [];
    List temp2=[];
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection(collection);
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    temp=await querySnapshot.docs.map((doc) => doc.data()).toList();
    temp2=await querySnapshot.docs.map((doc) => doc.id).toList();
    print(temp);
    for(int i=0;i<temp.length;i++){
      truck_list.add(TruckModel(
        name: temp[i]["name"],
        vehicleWeight: temp[i]["vehicleWeight"],
        id: temp2[i],
        totalCapacity: temp[i]["totalCapacity"]
      ));
      vehicalNameList.add(temp[i]['name']);

    }
    setState(() {});
    print(vehicalNameList);
  }

  getVehicalWieght(String selectedTruck) {
    print(selectedTruck);
    for(int i=0;i<truck_list.length;i++){
      if(selectedTruck==truck_list[i].name){
        slectedIndex=i;
      }
    }
    if(slectedIndex>=0){
      truck=truck_list[slectedIndex];
      setState(() {});
      CustomSnackBar.showSnackBar(context: context, message: "${truck.vehicleWeight}");
    }else{
      CustomSnackBar.failedSnackBar(context: context, message: "there is no record");
    }
  }

  getWeight() {
    double vehicleWeight=double.parse(truck.vehicleWeight!);
    double load=double.parse(loadOnVehicle!);
    return load-vehicleWeight;
  }

  activateListner() async{
    CustomLoader.showLoader(context: context);
    await database2.child("Total_Weight").onValue.listen((event) {
      final Object? temp=event.snapshot.value;
      loadOnVehicle=temp.toString();
      setState(() {});
    });
     CustomLoader.hideLoader(context);
  }

  Future<bool> addRecord(OrderModel order) {
    CollectionReference vehical = FirebaseFirestore.instance.collection("records");
    // Calling the collection to add a new user
    return vehical
    //adding to firebase collection
        .add({
      "name": nameCont.text,
      'vehicleName': selectedTruck,
     ' vehcileType': widget.vehicalType,
      'totalWieght': loadOnVehicle,
      'vehicleWeight': truck.vehicleWeight,
      'productWeight': getWeight().toString(),
     ' weightType': selectedWeightType,
    })
        .then((value) => true)
        .catchError((error) => false);
  }
 

}
