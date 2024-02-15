class CustomerReceiptModel {
  String? response;
  String? message;
  String? type;
  String? orderID;
  Data? data;

  CustomerReceiptModel(
      {this.response, this.message, this.type, this.orderID, this.data});

  CustomerReceiptModel.fromJson(Map<String, dynamic> json) {
    response = json['Response'];
    message = json['message'];
    type = json['type'];
    orderID = json['OrderID'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Response'] = response;
    data['message'] = message;
    data['type'] = type;
    data['OrderID'] = orderID;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  var driverID;
  String? startAddress;
  String? endAddress;
  String? distance;
  String? paymentMethod;
  String? estimatedTime;
  String? actualTime;
  String? total;
  String? carModel;
  String? insuranceNumber;
  String? name;
   var image;
  String? longitude;
  String? latitude;
  String? phone;
  String? plateNumber;
  String? vehicleName;

  Data(
      {this.id,
        this.startAddress,
        this.endAddress,
        this.distance,
        this.driverID,
        this.paymentMethod,
        this.estimatedTime,
        this.actualTime,
        this.total,
        this.carModel,
        this.insuranceNumber,
        this.name,
        this.image,
        this.longitude,
        this.latitude,
        this.phone,
        this.plateNumber,
        this.vehicleName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverID = json['driverID'];
    startAddress = json['start_address'];
    endAddress = json['end_address'];
    distance = json['distance'];
    paymentMethod = json['payment_method'];
    estimatedTime = json['estimated_time'];
    actualTime = json['actual_time'];
    total = json['total'];
    carModel = json['car_model'];
    insuranceNumber = json['insurance_number'];
    name = json['name'];
    image = json['image'];
    longitude = json['Longitude'];
    latitude = json['Latitude'];
    phone = json['phone'];
    plateNumber = json['plate_number'];
    vehicleName = json['vehicle_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['driverID'] = driverID;
    data['start_address'] = startAddress;
    data['end_address'] = endAddress;
    data['distance'] = distance;
    data['payment_method'] = paymentMethod;
    data['estimated_time'] = estimatedTime;
    data['actual_time'] = actualTime;
    data['total'] = total;
    data['car_model'] = carModel;
    data['insurance_number'] = insuranceNumber;
    data['name'] = name;
    data['image'] = image;
    data['Longitude'] = longitude;
    data['Latitude'] = latitude;
    data['phone'] = phone;
    data['plate_number'] = plateNumber;
    data['vehicle_name'] = vehicleName;
    return data;
  }
}