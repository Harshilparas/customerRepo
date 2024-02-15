// To parse this JSON data, do
//
//     final vechileCatPrice = vechileCatPriceFromJson(jsonString);

import 'dart:convert';

VechileCatPrice vechileCatPriceFromJson(String str) =>
    VechileCatPrice.fromJson(json.decode(str));

String vechileCatPriceToJson(VechileCatPrice data) =>
    json.encode(data.toJson());

class VechileCatPrice {
  bool success;
  List<VechilePrice> data;

  VechileCatPrice({
    required this.success,
    required this.data,
  });

  factory VechileCatPrice.fromJson(Map<String, dynamic> json) =>
      VechileCatPrice(
        success: json["success"],
        data: List<VechilePrice>.from(
            json["data"].map((x) => VechilePrice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class VechilePrice {
  int id;
  String category;
  double priceKm;
  double minKm;
  int minPrice;
  String seat;
  int extraKm;
  String totalFair;
  dynamic drivers;
  String? time;
  bool? isSelected;
  String? image;
  dynamic  is_pending ;
  dynamic  pending_amount;
  dynamic OrderID;

  VechilePrice(
      {required this.id,
      required this.category,
      required this.priceKm,
      required this.minKm,
      required this.minPrice,
      required this.seat,
      required this.extraKm,
      required this.totalFair,
      this.drivers,
      this.time,
      this.isSelected,
      this.image,
      this.is_pending,
      this.pending_amount,
      this.OrderID

      });

  factory VechilePrice.fromJson(Map<String, dynamic> json) => VechilePrice(
      id: json["id"],
      category: json["category"],
      priceKm: json["price_km"]?.toDouble(),
      minKm: json["min_km"]?.toDouble(),
      minPrice: json["min_price"],
      seat: json["seat"],
      extraKm: json["extra_km"],
      totalFair: json["total_fair"],
      drivers: json["drivers"],
      time: json["time"],
      isSelected: json['isSelected'] ?? false,
      image: json['image'],
      is_pending: json ["is_pending"],
      pending_amount: json ["pending_amount"],
      OrderID : json["OrderID"],

      );
    

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "price_km": priceKm,
        "min_km": minKm,
        "min_price": minPrice,
        "seat": seat,
        "extra_km": extraKm,
        "total_fair": totalFair,
        "drivers": drivers,
        "time": time,
        'image': image,
        'pending_amount':pending_amount,
        'is_pending':is_pending,
        'OrderID':OrderID,
      };
}
