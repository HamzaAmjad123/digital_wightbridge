class Trcuk {
  String? name;
  String? loadLimit;
  String? noPlate;
  String? truckType;
  String? totalWieght;
  String? vehicleWeight;

  Trcuk(
      {this.name,
        this.loadLimit,
        this.noPlate,
        this.truckType,
        this.totalWieght,
        this.vehicleWeight});

  Trcuk.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    loadLimit = json['loadLimit'];
    noPlate = json['noPlate'];
    truckType = json['truckType'];
    totalWieght = json['TotalWieght'];
    vehicleWeight = json['vehicleWeight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['loadLimit'] = this.loadLimit;
    data['noPlate'] = this.noPlate;
    data['truckType'] = this.truckType;
    data['TotalWieght'] = this.totalWieght;
    data['vehicleWeight'] = this.vehicleWeight;
    return data;
  }
}