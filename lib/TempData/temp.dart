// CustomScrollView(
//   primary: false,
//   shrinkWrap: true,
//   slivers: <Widget>[
//     SliverAppBar(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       expandedHeight: 250,
//       elevation: 0,
//       floating: true,
//       // title: Text("Digital WeightBridge",
//       //   style: TextStyle(color: bgColor),
//       // ),
//       // centerTitle: true,
//       // automaticallyImplyLeading: false,
//       // leading: new IconButton(
//       //   icon: new Icon(Icons.sort, color: Colors.orange),
//       //   onPressed: () => {
//       //     key.currentState!.openDrawer()},
//       // ),
//       flexibleSpace: FlexibleSpaceBar(
//           collapseMode: CollapseMode.parallax,
//           background:  Stack(
//             children: <Widget>[
//               CarouselSlider.builder(
//                 itemCount: _truckImages.length,
//                 options: CarouselOptions(
//                   autoPlay: true,
//                   autoPlayInterval: Duration(seconds: 5),
//                   height: 250,
//                   //aspectRatio: 1.0,
//                   viewportFraction: 1.0,
//                   onPageChanged: (index, reason) {
//                     currentSlide = index;
//                     setState((){});
//                   },
//                 ),
//                 itemBuilder: (context, index, realIdx) {
//                   return Container(
//                     width: double.infinity,
//                     child: Center(
//                         child: Image.asset(_truckImages[index],
//                             fit: BoxFit.cover, width: MediaQuery.of(context).size.width)),
//                   );
//                 },
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children:slider.map((Slide slide) {
//                     return Container(
//                       width: 20.0,
//                       height: 5.0,
//                       margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                         //color: currentSlide == slider.indexOf(slide) ? slide.indicatorColor : slide.indicatorColor!.withOpacity(0.4)
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           )
//       ).marginOnly(bottom: 42),
//     ),
//   ],
// ),










//Row of Buttons

/*Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Expanded(
child: CustomButton(
verticalMargin: 15.0,
text: "Get Data",
onTap: ()async{
},
),
), Expanded(
child: CustomButton(
verticalMargin: 15.0,
text: "Save Records",
onTap: ()async{
bool res=  await changeStatus(order.id!);
if(res){
NavigationServices.goNextAndKeepHistory(context: context, widget: PrinterScreen(order: order));
setState((){});
}

},
),
),
],
)*/
