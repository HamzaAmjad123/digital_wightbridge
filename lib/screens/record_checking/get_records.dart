import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../configs/colors.dart';
import '../../models/order_model.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Order> orderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
  }

  Future getData() async {
    await getAllOrders("orders");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: orderList.length,
            itemBuilder: (context,index){
              return  Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            }
        ),
      ),
    );
  }

  getAllOrders(String collection) async {
    List temp = [];
    List temp2 = [];
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection(collection);
    QuerySnapshot querySnapshot = await _collectionRef.get();
    temp = await querySnapshot.docs.map((doc) => doc.data()).toList();
    temp2 = await querySnapshot.docs.map((doc) => doc.id).toList();
    for (int i = 0; i < temp.length; i++) {
      if (temp[i]['status'] == "active") {
        orderList.add(Order(
            id: temp2[i],
            name: temp[i]["name"],
            noPlate: temp[i]["noPlate"],
            truckType: temp[i]["truckType"],
            status: temp[i]["status"],
            bridgeWieght: temp[i]["bridge wieght"],
            vehicleWeight: temp[i]["vehicleWeight"],
            wighttype: temp[i]["wighet type"]));
      }
    }
    setState(() {});
  }
}
