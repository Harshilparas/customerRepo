class DriverDetailModel {
  dynamic response;
  dynamic message;
 dynamic type;
  Data? data;

  DriverDetailModel({this.response, this.message, this.type, this.data});

  DriverDetailModel.fromJson(Map<String, dynamic> json) {
    response = json['Response'];
    message = json['message'];
    type = json['type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Response'] = this.response;
    data['message'] = this.message;
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic driverID;
  dynamic startAddress;
  dynamic endAddress;
  dynamic distance;
  dynamic paymentMethod;
  dynamic estimatedTime;
  dynamic actualTime;
  dynamic total;
  dynamic name;
  dynamic profile_photo;
  dynamic latitude;
  dynamic longitude;
  var car_model;
  var plate_number;
  dynamic DriverRating;

  Data(
      {this.id,
        this.startAddress,
        this.driverID,
        this.endAddress,
        this.distance,
        this.paymentMethod,
        this.estimatedTime,
        this.actualTime,
        this.total,
        this.name,
        this.profile_photo,
        this.latitude,
        this.car_model,
        this.plate_number,
        this.DriverRating,
        this.longitude});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAddress = json['start_address'];
    DriverRating = json['DriverRating']??"";
    driverID = json['driverID'];
    endAddress = json['end_address'];
    distance = json['distance'];
    paymentMethod = json['payment_method'];
    estimatedTime = json['estimated_time'];
    actualTime = json['actual_time'];
    total = json['total'];
    name = json['name'];
    profile_photo = json['profile_photo'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    car_model = json['car_model'];
    plate_number = json['plate_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['start_address'] = this.startAddress;
    data['driverID'] = this.driverID;
    data['DriverRating'] = this.DriverRating;
    data['end_address'] = this.endAddress;
    data['distance'] = this.distance;
    data['payment_method'] = this.paymentMethod;
    data['estimated_time'] = this.estimatedTime;
    data['actual_time'] = this.actualTime;
    data['total'] = this.total;
    data['name'] = this.name;
    data['profile_photo'] = this.profile_photo;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['car_model'] = this.car_model;
    data['plate_number'] = this.plate_number;
    return data;
  }
}