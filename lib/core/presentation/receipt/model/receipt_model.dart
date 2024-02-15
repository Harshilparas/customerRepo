class ReceiptModel {
  int? success;
  OrderReceipt? orderReceipt;

  ReceiptModel({this.success, this.orderReceipt});

  ReceiptModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    orderReceipt = json['Order receipt'] != null
        ? OrderReceipt.fromJson(json['Order receipt'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (orderReceipt != null) {
      data['Order receipt'] = orderReceipt!.toJson();
    }
    return data;
  }
}

class OrderReceipt {
  String? id;
  String? driverId;
  String? distance;
  String? actualDistance;
  String? actualTime;
  String? total;
  String? grandTotal;
  String? extraDistance;
  String? extraDistancePrice;
  String? extraTime;
  String? extraTimePrice;
  String? orderTime;
  String? startTime;
  String? endTime;
  String? status;
  String? image;
  String? userName;
  String? userPhone;
  var rating;
  String? plateNumber;
  String? vehicleName;
  String? carModel;
  int? paymentMethod;
  VehicleCategory? vehicleCategory;
  String? timestamp;

  OrderReceipt(
      {this.id,
      this.driverId,
      this.distance,
      this.actualDistance,
      this.actualTime,
      this.total,
      this.grandTotal,
      this.extraDistance,
      this.extraDistancePrice,
      this.orderTime,
      this.startTime,
      this.endTime,
      this.status,
      this.image,
      this.userName,
      this.userPhone,
      this.rating,
      this.plateNumber,
      this.vehicleName,
      this.carModel,
      this.paymentMethod,
      this.vehicleCategory,
      this.extraTime,
      this.extraTimePrice,
      this.timestamp});

  OrderReceipt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverId = json['driver_id'];
    distance = json['distance'];
    actualDistance = json['actual_distance'];
    actualTime = json['actual_time'];
    total = json['total'];
    grandTotal = json['grand_total'];
    extraDistance = json['extra_distance'];
    extraDistancePrice = json['extra_distance_price'];
    extraTime = json['extra_time'];
    extraTimePrice = json['extra_time_price'];
    orderTime = json['order_time'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    image = json['image'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    rating = json['rating'];
    plateNumber = json['plate_number'];
    vehicleName = json['vehicle_name'];
    carModel = json['car_model'];
    paymentMethod = json['payment_method'];
    vehicleCategory = json['vehicle_category'] != null
        ? VehicleCategory.fromJson(json['vehicle_category'])
        : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['driver_id'] = driverId;
    data['distance'] = distance;
    data['actual_distance'] = actualDistance;
    data['actual_time'] = actualTime;
    data['total'] = total;
    data['grand_total'] = grandTotal;
    data['extra_distance'] = extraDistance;
    data['extra_distance_price'] = extraDistancePrice;
    data['extra_time'] = extraTime;
    data['extra_time_price'] = extraTimePrice;
    data['order_time'] = orderTime;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['image'] = image;
    data['user_name'] = userName;
    data['user_phone'] = userPhone;
    data['rating'] = rating;
    data['plate_number'] = plateNumber;
    data['vehicle_name'] = vehicleName;
    data['car_model'] = carModel;
    data['payment_method'] = paymentMethod;
    if (vehicleCategory != null) {
      data['vehicle_category'] = vehicleCategory!.toJson();
    }
    data['timestamp'] = timestamp;
    return data;
  }
}

class VehicleCategory {
  int? id;
  String? category;
  double? priceKm;
  double? priceMin;
  dynamic techFee;
  int? baseFare;
  int? distance;
  double? minKm;
  int? minPrice;
  int? extraKm;
  String? seat;
  String? image;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  VehicleCategory(
      {this.id,
      this.category,
      this.priceKm,
      this.priceMin,
      this.techFee,
      this.baseFare,
      this.distance,
      this.minKm,
      this.minPrice,
      this.extraKm,
      this.seat,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  VehicleCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    priceKm = json['price_km'];
    priceMin = json['price_min'];
    techFee = json['tech_fee'];
    baseFare = json['base_fare'];
    distance = json['distance'];
    minKm = json['min_km'];
    minPrice = json['min_price'];
    extraKm = json['extra_km'];
    seat = json['seat'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['price_km'] = priceKm;
    data['price_min'] = priceMin;
    data['tech_fee'] = techFee;
    data['base_fare'] = baseFare;
    data['distance'] = distance;
    data['min_km'] = minKm;
    data['min_price'] = minPrice;
    data['extra_km'] = extraKm;
    data['seat'] = seat;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
