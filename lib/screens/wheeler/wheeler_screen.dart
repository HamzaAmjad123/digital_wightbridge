import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_weighbridge/screens/wheeler/vehicle_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/colors.dart';
import '../../helper_services/navigation_services.dart';
import '../../helper_widgets/custom_vehicals_card.dart';
import '../../models/slider.dart';
import '../home/custom_drawer.dart';

class SelectWheeler extends StatefulWidget {
  const SelectWheeler({Key? key}) : super(key: key);

  @override
  State<SelectWheeler> createState() => _SelectWheelerState();
}

class _SelectWheelerState extends State<SelectWheeler> {
  List<Slide> slider = [];
  List<String> _truckImages=[
    "assets/images/truck0.jpg",
    "assets/images/truck1.jpg",
    "assets/images/truck2.jpg",
    "assets/images/truck3.jpg",
    "assets/images/truck5.jpg",
    "assets/images/truck6.jpg",
    "assets/images/truck.jpg",
  ];
  int currentSlide = 0;
  GlobalKey<ScaffoldState> key=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomScrollView(
              primary: false,
              shrinkWrap: true,
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  expandedHeight: 250,
                  elevation: 0.5,
                  floating: true,
                  iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                  title: Text("Digital WeightBridge",
                    style: TextStyle(color: bgColor),
                  ),
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  leading: new IconButton(
                    icon: new Icon(Icons.sort, color: Colors.black87),
                    onPressed: () => {
                      key.currentState!.openDrawer()},
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background:  Stack(
                        children: <Widget>[
                          CarouselSlider.builder(
                            itemCount: _truckImages.length,
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              height: 250,
                              //aspectRatio: 1.0,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                currentSlide = index;
                                setState((){});
                              },
                            ),
                            itemBuilder: (context, index, realIdx) {
                              return Container(
                                width: double.infinity,
                                child: Center(
                                    child: Image.asset(_truckImages[index],
                                        fit: BoxFit.cover, width: MediaQuery.of(context).size.width)),
                              );
                            },
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children:slider.map((Slide slide) {
                                return Container(
                                  width: 20.0,
                                  height: 5.0,
                                  margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    //color: currentSlide == slider.indexOf(slide) ? slide.indicatorColor : slide.indicatorColor!.withOpacity(0.4)
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      )
                  ).marginOnly(bottom: 42),
                ),
              ],
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
