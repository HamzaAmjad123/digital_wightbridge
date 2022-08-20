class OrderModel {
  String? id;
  String? name;
  String? noPlate;
  String? truckType;
  String? vehicleWeight;
  String? bridgeWieght;
  String? wighttype;
  String? status;

  OrderModel(
      {
        this.id,
        this.name,
        this.noPlate,
        this.truckType,
        this.status,
        this.bridgeWieght,
        this.vehicleWeight,
        this.wighttype});

  // OrderModel.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   noPlate = json['noPlate'];
  //   truckType = json['truckType'];
  //   vehicleWeight = json['vehicleWeight'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   data['noPlate'] = this.noPlate;
  //   data['truckType'] = this.truckType;
  //   data['vehicleWeight'] = this.vehicleWeight;
  //   return data;
  // }
}