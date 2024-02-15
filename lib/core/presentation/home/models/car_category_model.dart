import 'dart:convert';

CarCategoryModel carCategoryModelFromJson(String str) =>
    CarCategoryModel.fromJson(json.decode(str));

String carCategoryModelToJson(CarCategoryModel data) =>
    json.encode(data.toJson());

class CarCategoryModel {
  String? carImage;
  String? carName;
  String? carPrice;
  int? carPersonCount;
  String? time;

  CarCategoryModel({
    this.carImage,
    this.carName,
    this.carPrice,
    this.carPersonCount,
    this.time,
  });

  factory CarCategoryModel.fromJson(Map<String, dynamic> json) =>
      CarCategoryModel(
        carImage: json["car_image"],
        carName: json["car_name"],
        carPrice: json["car_price"],
        carPersonCount: json["car_person_count"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "car_image": carImage,
        "car_name": carName,
        "car_price": carPrice,
        "car_person_count": carPersonCount,
        "time": time,
      };
}
