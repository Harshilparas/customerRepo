// To parse this JSON data, do
//
//     final rideInProgressModel = rideInProgressModelFromJson(jsonString);

import 'dart:convert';

RideInProgressModel rideInProgressModelFromJson(String str) => RideInProgressModel.fromJson(json.decode(str));

String rideInProgressModelToJson(RideInProgressModel data) => json.encode(data.toJson());

class RideInProgressModel {
    dynamic success;
    Order? order;
    CustomerDetails? customerDetails;
    DriverDetails? driverDetails;

    RideInProgressModel({
        this.success,
        this.order,
        this.customerDetails,
        this.driverDetails,
    });

    factory RideInProgressModel.fromJson(Map<String, dynamic> json) => RideInProgressModel(
        success: json["success"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        customerDetails: json["customer_details"] == null ? null : CustomerDetails.fromJson(json["customer_details"]),
        driverDetails: json["driver_details"] == null ? null : DriverDetails.fromJson(json["driver_details"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "order": order?.toJson(),
        "customer_details": customerDetails?.toJson(),
        "driver_details": driverDetails?.toJson(),
    };
}

class CustomerDetails {
    dynamic id;
    String? name;
    String? email;
    String? phone;
    String? image;
    dynamic rating;

    CustomerDetails({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.rating,
    });

    factory CustomerDetails.fromJson(Map<String, dynamic> json) => CustomerDetails(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        rating: json["rating"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "rating": rating,
    };
}

class DriverDetails {
    dynamic id;
    String? name;
    String? profilePhoto;
    String? phone;
    String? carModel;
    String? plateNumber;
    dynamic rating;
    dynamic latitude;
    dynamic longitude;

    DriverDetails({
        this.id,
        this.name,
        this.profilePhoto,
        this.phone,
        this.carModel,
        this.plateNumber,
        this.rating,
         this.latitude,
         this.longitude,
    });

    factory DriverDetails.fromJson(Map<String, dynamic> json) => DriverDetails(
        id: json["id"],
        name: json["name"],
        profilePhoto: json["profile_photo"],
        phone: json["phone"],
        carModel: json["car_model"],
        plateNumber: json["plate_number"],
        rating: json["rating"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_photo": profilePhoto,
        "phone": phone,
        "car_model": carModel,
        "plate_number": plateNumber,
        "rating": rating,
        "Latitude": latitude,
        "Longitude": longitude,
    };
}

class Order {
    dynamic id;
    int? driverId;
    dynamic customerId;
    dynamic total;
    dynamic orderStatus;
    String? startCoordinate;
    String? endCoordinate;
    String? startAddress;
    String? endAddress;
    String? distance;
   dynamic start_time;
   dynamic  order_time;
   dynamic  reached_time;

    Order({
        this.id,
        this.driverId,
        this.customerId,
        this.total,
        this.orderStatus,
        this.startCoordinate,
        this.endCoordinate,
        this.startAddress,
        this.endAddress,
        this.distance,
        this.order_time,
        this.start_time,
        this.reached_time,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        driverId: json["driver_id"],
        customerId: json["customer_id"],
        total: json["total"]?.toDouble(),
        orderStatus: json["order_status"],
        startCoordinate: json["start_coordinate"],
        endCoordinate: json["end_coordinate"],
        startAddress: json["start_address"],
        endAddress: json["end_address"],
        distance: json["distance"],
        order_time: json["order_time"],
        start_time: json["start_time"],
        reached_time: json["reached_time"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "driver_id": driverId,
        "customer_id": customerId,
        "total": total,
        "order_status": orderStatus,
        "start_coordinate": startCoordinate,
        "end_coordinate": endCoordinate,
        "start_address": startAddress,
        "end_address": endAddress,
        "distance": distance,
        "order_time":order_time,
        "start_time":start_time,
        "reached_time":reached_time,
    };
}
