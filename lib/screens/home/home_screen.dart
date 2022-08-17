import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_weighbridge/helper_services/custom_snacbar.dart';
import 'package:digital_weighbridge/screens/Auth/Authentication.dart';
import 'package:digital_weighbridge/screens/record_checking/get_records.dart';
import 'package:digital_weighbridge/screens/record_checking/load_limit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../configs/colors.dart';
import '../../helper_services/navigation_services.dart';
import '../../helper_widgets/custom_vehicals_card.dart';
import '../../models/slider.dart';
import '../../models/user_model.dart';
import '../qr_and_printer/qr_code.dart';
import '../wheeler/wheeler_screen.dart';
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
  initState(){
    super.initState();
   getUserDetails();
  }
  Future<void> getUserDetails()async{
    usermodels= await Authentication().getUser(
    );
  }
  TextEditingController Number=new TextEditingController();
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
                    icon: new Icon(Icons.sort, color: Colors.orange),
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
            Container(
              child: Column(children: [
                CustomVehiclesCard(
                  truckName: "New Truck",
                  truckUrl: "assets/images/semi.png",
                  onTap: (){
                    NavigationServices.goNextAndKeepHistory(context: context, widget: SelectWheeler());
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
                  truckUrl: "assets/icons/qr_image.png",
                  onTap: ()async{
                    await permissionServiceCall();
                  },
                )
              ],),
            )
          ],
        ),
      ),
    );
  }

  permissionServiceCall() async {
    await permissionServices().then(
          (value) {
        if (value != null) {
          if (
          value[Permission.camera]!.isGranted){
            /* ========= New Screen Added  ============= */
            NavigationServices.goNextAndKeepHistory(context: context, widget: QrCode());
            setState((){});
          }
        }
      },
    );
  }
  /*Permission services*/
  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      //add more permission to request here.
    ].request();

    if (statuses[Permission.camera]!.isPermanentlyDenied) {
      CustomSnackBar.failedSnackBar(context: context, message: "Qr COde need Camera Permisions so Please enable camre Ist");

      await openAppSettings().then(
            (value) async {
          if (value) {
            if (await Permission.camera.status.isPermanentlyDenied == true &&
                await Permission.camera.status.isGranted == false) {
              openAppSettings();
              // permissionServiceCall(); /* opens app settings until permission is granted */
            }
          }
        },
      );
      openAppSettings();
      //setState(() {});
    } else {
      if (statuses[Permission.camera]!.isDenied) {
        permissionServiceCall();
      }
    }
    /*{Permission.camera: PermissionStatus.granted, Permission.storage: PermissionStatus.granted}*/
    return statuses;
  }


//   doesUserExist(currentUserName) async {
//     try {
// // if the size of value is greater then 0 then that doc exist.
//       await FirebaseFirestore.instance
//           .collection('Users')
//           .where('email', isEqualTo: currentEmail)
//           .get()
//           .then((value) => value.size > 0 ? true : false);
//     } catch (e) {
//       debugPrint(e.toString());
//
//     }
//   }

//   doesUserExist(currentUserName) async {
//     try {
// // if the size of value is greater then 0 then that doc exist.
//       await FirebaseFirestore.instance
//           .collection('Users')
//           .where('email', isEqualTo: currentEmail)
//           .get()
//           .then((value) => value.size > 0 ? true : false);
//     } catch (e) {
//       debugPrint(e.toString());
//
//     }
//   }



}
