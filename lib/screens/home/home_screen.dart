import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_weighbridge/screens/Authentication.dart';
import 'package:digital_weighbridge/screens/History.dart';
import 'package:digital_weighbridge/screens/load_limit.dart';
import 'package:digital_weighbridge/screens/qr_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/colors.dart';
import '../../helper_services/navigation_services.dart';
import '../../helper_widgets/custom_vehicals_card.dart';
import '../../models/slider.dart';
import '../../models/user_model.dart';
import '../add_Truck.dart';
import 'custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel usermodels = UserModel();
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
  oninit()async{
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async =>  usermodels=await Authentication().getUser());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: CustomDrawer(),
      body: Column(
        children: [
          CustomScrollView(
            primary: false,
            shrinkWrap: true,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 300,
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
                truckName: "New Truck",
                truckUrl: "assets/images/semi.png",
                onTap: (){
                  NavigationServices.goNextAndKeepHistory(context: context, widget: AddTruck());
                  setState((){});
                },
              ),
              CustomVehiclesCard(
                truckName: "History",
                truckUrl: "assets/icons/history.png",
                onTap: (){
                  NavigationServices.goNextAndKeepHistory(context: context, widget: History());
                  setState((){});
                },

              ),
              CustomVehiclesCard(
                truckName: "Truck Limits",
                truckUrl: "assets/icons/Overloading.png",
                onTap: (){
                  NavigationServices.goNextAndKeepHistory(context: context, widget: LoadLimit());
                  setState((){});
                },
              ),
              CustomVehiclesCard(
                truckName: "Qr Code",
                truckUrl: "assets/images/semi.png",
                onTap: (){
                  NavigationServices.goNextAndKeepHistory(context: context, widget: QrCode());
                  setState((){});
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
