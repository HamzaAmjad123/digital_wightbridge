import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_weighbridge/screens/wheeler/vehicle_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../configs/colors.dart';
import '../../helper_services/navigation_services.dart';
import '../../helper_widgets/custom_vehicals_card.dart';
import '../home/custom_drawer.dart';

class SelectWheeler extends StatefulWidget {
  const SelectWheeler({Key? key}) : super(key: key);

  @override
  State<SelectWheeler> createState() => _SelectWheelerState();
}

class _SelectWheelerState extends State<SelectWheeler> {
  List<String> _truckImages=[
    "assets/images/truck1.jpg",
    "assets/images/truck2.jpg",
    "assets/images/truck3.jpg",
    "assets/images/truck5.jpg",
    "assets/images/truck.jpg",
  ];
  int currentSlide = 0;
  GlobalKey<ScaffoldState> key=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text("All Wheeler",style :TextStyle(color: Colors.white,fontSize: 14)),
        leading: IconButton(
          icon: new Icon(Icons.sort, color: Colors.white),
          onPressed: () => {
            key.currentState!.openDrawer()},
        ),
      ),
      key: key,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(height: 220.0,viewportFraction: 1.0,
                  enlargeCenterPage: false,autoPlay: true),
              items: _truckImages.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 10.0),

                      child: Center(
                          child: Image.asset('$i',
                              fit: BoxFit.cover, width: MediaQuery.of(context).size.width)),
                      //child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                    );
                  },
                );
              }).toList(),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                CustomVehiclesCard(
                  truckName: "4 Wheeler",
                  truckUrl: "assets/icons/4_wheel.png",
                  onTap: (){
                    NavigationServices.goNextAndKeepHistory(context: context, widget: VehicleDetailsScreen(vehicalType: "4Wheeler",));
                    setState((){});
                  },
                ),
                CustomVehiclesCard(
                  truckName: "6 Wheeler",
                  truckUrl: "assets/icons/6_wheel.png",
                  onTap: (){
                    NavigationServices.goNextAndKeepHistory(context: context, widget: VehicleDetailsScreen(vehicalType: "6Wheeler",));
                    setState((){});
                  },

                ),
                CustomVehiclesCard(
                  truckName: "10 Wheeler",
                  truckUrl: "assets/icons/10_wheel.png",
                  onTap: (){
                    NavigationServices.goNextAndKeepHistory(context: context, widget: VehicleDetailsScreen(vehicalType: "10Wheeler",));
                    setState((){});
                  },
                ),
                CustomVehiclesCard(
                  truckName: "12 wheeler",
                  truckUrl: "assets/icons/12_wheel.png",
                  onTap: (){
                    NavigationServices.goNextAndKeepHistory(context: context, widget: VehicleDetailsScreen(vehicalType: "12Wheeler",));
                    setState((){});
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
