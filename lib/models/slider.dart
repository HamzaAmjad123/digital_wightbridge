import 'dart:ui';

class Slide {
  String? text;
  String? button;
  String? textPosition;
  Color? textColor;
  Color? buttonColor;
  Color? backgroundColor;
  Color? indicatorColor;
  Media? image;
  String? imageFit;
  bool? enabled;

  Slide({
    this.text,
    this.button,
    this.textPosition,
    this.textColor,
    this.buttonColor,
    this.backgroundColor,
    this.indicatorColor,
    this.image,
    this.imageFit,
    this.enabled,
  });

  // Slide.fromJson(Map<String, dynamic> json) {
  //   super.fromJson(json);
  //   order = intFromJson(json, 'order');
  //   text = transStringFromJson(json, 'text');
  //   button = transStringFromJson(json, 'button');
  //   textPosition = stringFromJson(json, 'text_position');
  //   textColor = colorFromJson(json, 'text_color');
  //   buttonColor = colorFromJson(json, 'button_color');
  //   backgroundColor = colorFromJson(json, 'background_color');
  //   indicatorColor = colorFromJson(json, 'indicator_color');
  //   image = mediaFromJson(json, 'image');
  //   imageFit = stringFromJson(json, 'image_fit');
  //   eService = json['e_service_id'] != null ? EService(id: json['e_service_id'].toString()) : null;
  //   eProvider = json['e_provider_id'] != null ? EProvider(id: json['e_provider_id'].toString()) : null;
  //   enabled = boolFromJson(json, 'enabled');
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['text'] = this.text;
  //   return data;
  // }
}
class Media {
  String? id;
  String? name;
  String? url;
  String? thumb;
  String? icon;
  String? size;

  Media({required String id, required String url, required String thumb, required String icon}) {
   /* this.id = id ?? "";
    this.url = url ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
    this.thumb = thumb ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
    this.icon = icon ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";*/
  }
}
