import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_weighbridge/configs/colors.dart';
import 'package:digital_weighbridge/helper_services/custom_snacbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helper_services/custom_loader.dart';
import '../../helper_widgets/custom_button.dart';


class LoadLimit extends StatefulWidget {
  const LoadLimit({Key? key}) : super(key: key);

  @override
  State<LoadLimit> createState() => _LoadLimitState();
}

class _LoadLimitState extends State<LoadLimit> {
  @override
  initState() {
    super.initState();
  }

  String selectedvehical = "Select Vehical";
  List<String> vehicalsList = [
    "4Wheeler",
    "6Wheeler",
    "10Wheeler",
    "12Wheeler"
  ];
  String slecetdTruck = "Select your vehicle";
  List<String> truckList = [];
  List<String> vehicalLoadLimit = [];
  int? slectedIndex;
  TextEditingController weightCont = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          "Check Load Limits",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Your Load in Kg",
                  style: TextStyle(color: bgColor, fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 45.0,
                    child: TextField(
                      cursorColor: blackColor,
                      cursorHeight: 30.0,
                      style: TextStyle(
                          height: 2.3,
                          color: blackColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                      controller: weightCont,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      obscureText: false,
                      onSubmitted: (value) {
                        weightCont.text = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Load",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 8.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: bgColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: bgColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
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
                    truckList.clear();
                    vehicalLoadLimit.clear();
                    selectedvehical = value!;
                    CustomLoader.showLoader(context: context);
                    getData(selectedvehical);
                    CustomLoader.hideLoader(context);
                    setState(() {});
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              height: 45.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2.0, color: bgColor),
              ),
              child: truckList.isEmpty
                  ? Center(
                      child: Text(" select Vehical type ist",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          )),
                    )
                  : DropdownButton(
                      style: TextStyle(
                          height: 2.3,
                          color: blackColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal),
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text(slecetdTruck),
                      items: truckList.map((item) {
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
                        slecetdTruck = value!;
                        setState(() {});
                      }),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              width: MediaQuery.of(context).size.width * 0.9,
              buttonColor: bgColor,
              fontWeight: FontWeight.bold,
              onTap: () async {
                await checkWieght(
                    weightCont.text,slecetdTruck);
              },
              text: "Check",
              fontSize: 18.0,
              verticalMargin: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  Future getData(String collection) async {
    List trucks_list = [];
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection(collection);
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    trucks_list = await querySnapshot.docs.map((doc) => doc.data()).toList();
    for(int i=0;i<trucks_list.length;i++){
      truckList.add(trucks_list[i]['name']);
      vehicalLoadLimit.add(trucks_list[i]['totalCapacity']);
    }
    setState(() {});
    /*return users_list.toList();*/
  }
  checkWieght(String load,  String vehical) async{
    for(int i=0;i<truckList.length;i++){
      if(vehical==truckList[i]){
        slectedIndex=i;
      }
    }
    int weight=int.parse(load);
    int capacity=int.parse(vehicalLoadLimit[slectedIndex!]);
    if(weight<capacity){
      print(capacity);
      CustomSnackBar.showSnackBar(context: context, message: "This Vehical is suitable for you");
    }else{
      print(capacity);
      CustomSnackBar.failedSnackBar(context: context, message: "Your load is maximum then Vehical Capcity");
    }
  }
}
