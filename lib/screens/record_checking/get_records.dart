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
  List<OrderModel> orderList = [];

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
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text("All Records"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: orderList.length,
              itemBuilder: (context,index){
                return  HistoryWidget(order: orderList[index]);
              }
          ),
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
        orderList.add(OrderModel(
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


class HistoryWidget extends StatefulWidget {
  OrderModel order;
   HistoryWidget({required this.order});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(15.0),
      ),
      shadowColor: bgColor,
      elevation: 10.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: widget.order.truckType=="4wheeler"?Image.asset("assets/icons/4_wheel.png"):widget.order.truckType=="6wheeler"?Image.asset("assets/icons/6_wheel.png"):widget.order.truckType=="10wheeler"?Image.asset("assets/icons/10_wheel.png"):widget.order.truckType=="12wheeler"?Image.asset("assets/icons/12_wheel.png"):Image.asset(''),
              title: Text(widget.order.name!,style: TextStyle(color: bgColor,fontSize: 15.0,fontWeight: FontWeight.w600),),
              subtitle: Text(widget.order.noPlate!),
              trailing: Container(

                padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                  decoration: BoxDecoration(
                    color: widget.order.status=="active"?Colors.green:bgColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: widget.order.status=="active"?Colors.green:bgColor
                    )
                  ),
                  child: Text(widget.order.status!,style: TextStyle(color: widget.order.status=="active"?whiteColor:whiteColor),)),
            ),
            Divider(
              color: bgColor,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Weight: ${widget.order.bridgeWieght!}"),
                Text("Weight Type: ${widget.order.wighttype}"),
              ],
            )
          ],
        ),

      ),
    );
  }
}
