class OrderModel {String? id;
  String? name;
  String? vehicleWeight;
  String? totalWieght;
  String? weightType;
  String? vehcileType;
  String? vehicleName;
  String? productWeight;

  OrderModel(
      {
        this.id,
        this.name,
        this.vehicleName,
        this.vehcileType,
        this.totalWieght,
        this.vehicleWeight,
        this.productWeight,
        this.weightType});

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