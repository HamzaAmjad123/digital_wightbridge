import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../configs/colors.dart';
import '../../helper_services/navigation_services.dart';
import '../../models/order_model.dart';
import '../home/home_screen.dart';

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
    await getAllOrders("records");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        NavigationServices.goNextAndDoNotKeepHistory(
            context: context, widget: HomeScreen());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          centerTitle: true,
          title: Text("All Records",style: TextStyle(color: Colors.white),),
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
            NavigationServices.goNextAndDoNotKeepHistory(
                context: context, widget: HomeScreen());
          },),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  return HistoryWidget(order: orderList[index]);
                }),
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
    print(temp);
    print(temp2);
    for (int i = 0; i < temp.length; i++) {
      orderList.add(OrderModel(
          id: temp2[i],
          name: temp[i]["name"],
          vehicleWeight: temp[i]["vehicleWeight"],
          totalWieght: temp[i]["totalWieght"],
          weightType: temp[i][" weightType"],
          vehcileType: temp[i]["vehcileType"],
          vehicleName: temp[i]["vehicleName"],
          productWeight: temp[i]["productWeight"]));
    }
    print(orderList);
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
        borderRadius: BorderRadius.circular(15.0),
      ),
      shadowColor: bgColor,
      elevation: 10.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                leading: widget.order.vehcileType == "4Wheeler"
                    ? Image.asset("assets/icons/4_wheel.png")
                    : widget.order.vehcileType == "6Wheeler"
                        ? Image.asset("assets/icons/6_wheel.png")
                        : widget.order.vehcileType == "10Wheeler"
                            ? Image.asset("assets/icons/10_wheel.png")
                            : widget.order.vehcileType == "12Wheeler"
                                ? Image.asset("assets/icons/12_wheel.png")
                                : Image.asset('assets/images/semi.png'),
                title: Text(
                  widget.order.name!,
                  style: TextStyle(
                      color: bgColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(widget.order.vehicleName!),
                trailing: Text(widget.order.weightType!)),
            Divider(
              color: bgColor,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Weight: ${widget.order.totalWieght!}"),
                Text("Product Weight: ${widget.order.productWeight}"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
