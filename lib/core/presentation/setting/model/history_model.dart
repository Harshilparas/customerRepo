class HistoryModel {
  int? success;
  List<HistoryOrder>? historyOrder;


  HistoryModel({this.success, this.historyOrder});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['history_order'] != null) {
      historyOrder = <HistoryOrder>[];
      json['history_order'].forEach((v) {
        historyOrder!.add(HistoryOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (historyOrder != null) {
      data['history_order'] =
          historyOrder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryOrder {
  String? id;
  var booking_status;
  String? driverId;
  String? driverName;
  String? image;
  String? plateNumber;
  dynamic? rating;
  String? startCoordinate;
  String? endCoordinate;
  String? startAddress;
  String? endAddress;
  String? distance;
  String? total;
  var grandTotal;
  var tip;
  String? orderTime;
  var status;
  String? timeSchool;
  String? timeAfterSchool;
  String? paymentMethod;
  String? taxiType;
  var timestamp;
  Category? category;
  dynamic paymentStatus;
  List<RatingList>? ratingList;

  HistoryOrder(
      {this.id,
        this.driverId,
        this.booking_status,
        this.driverName,
        this.image,
        this.plateNumber,
        this.rating,
        this.startCoordinate,
        this.endCoordinate,
        this.startAddress,
        this.endAddress,
        this.distance,
        this.total,
        this.grandTotal,
        this.tip,
        this.orderTime,
        this.status,
        this.timeSchool,
        this.timeAfterSchool,
        this.paymentMethod,
        this.taxiType,
        this.timestamp,
        this.category,
        this.paymentStatus,
        this.ratingList});

  HistoryOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverId = json['driver_id'];
    booking_status = json['booking_status'];
    driverName = json['driver_name'];
    image = json['image'];
    plateNumber = json['plate_number'];
    rating = json['rating'];
    startCoordinate = json['start_coordinate'];
    endCoordinate = json['end_coordinate'];
    startAddress = json['start_address'];
    endAddress = json['end_address'];
    distance = json['distance'];
    total = json['total'];
    grandTotal = json['grand_total'];
    tip = json['tip'];
    orderTime = json['order_time'];
    status = json['status'];
    timeSchool = json['time_school'];
    timeAfterSchool = json['time_after_school'];
    paymentMethod = json['payment_method'];
    taxiType = json['taxi_type'];
    timestamp = json['timestamp'];
    paymentStatus = json['payment_status'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    if (json['rating_list'] != null) {
      ratingList = <RatingList>[];
      json['rating_list'].forEach((v) {
        ratingList!.add(RatingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['driver_id'] = driverId;
    data['booking_status'] = booking_status;
    data['driver_name'] = driverName;
    data['image'] = image;
    data['plate_number'] = plateNumber;
    data['rating'] = rating;
    data['start_coordinate'] = startCoordinate;
    data['end_coordinate'] = endCoordinate;
    data['start_address'] = startAddress;
    data['end_address'] = endAddress;
    data['distance'] = distance;
    data['total'] = total;
    data['grand_total'] = grandTotal;
    data['tip'] = tip;
    data['order_time'] = orderTime;
    data['status'] = status;
    data['time_school'] = timeSchool;
    data['time_after_school'] = timeAfterSchool;
    data['payment_method'] = paymentMethod;
    data['taxi_type'] = taxiType;
    data['timestamp'] = timestamp;
    data['payment_status'] = paymentStatus;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (ratingList != null) {
      data['rating_list'] = ratingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? category;
  double? priceKm;
  double? priceMin;
  dynamic? techFee;
  var baseFare;
  int? distance;
  double? minKm;
  int? minPrice;
  int? extraKm;
  String? seat;
  String? image;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Category(
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

  Category.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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

class RatingList {
  int? id;
  int? senderId;
  int? receiverId;
  int? orderId;
  String? rating;
  String? review;
  int? type;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? givenTime;

  RatingList(
      {this.id,
        this.senderId,
        this.receiverId,
        this.orderId,
        this.rating,
        this.review,
        this.type,
        this.status,
        this.givenTime,
        this.createdAt,
        this.updatedAt});

  RatingList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    orderId = json['order_id'];
    rating = json['rating'];
    review = json['review'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    givenTime = json['givenTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['order_id'] = orderId;
    data['rating'] = rating;
    data['review'] = review;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['givenTime'] = givenTime;
    return data;
  }
}