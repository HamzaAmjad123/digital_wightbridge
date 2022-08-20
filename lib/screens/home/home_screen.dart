import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_weighbridge/helper_services/custom_snacbar.dart';
import 'package:digital_weighbridge/screens/Auth/Authentication.dart';
import 'package:digital_weighbridge/screens/record_checking/get_records.dart';
import 'package:digital_weighbridge/screens/record_checking/load_limit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../configs/colors.dart';
import '../../helper_services/navigation_services.dart';
import '../../helper_widgets/custom_vehicals_card.dart';
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
  List<String> _truckImages=[
    "assets/images/truck1.jpg",
    "assets/images/truck2.jpg",
    "assets/images/truck3.jpg",
    "assets/images/truck5.jpg",
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
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text("Digital WeightBridge",style :TextStyle(color: Colors.white,fontSize: 14)),
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
                    );
                  },
                );
              }).toList(),
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
