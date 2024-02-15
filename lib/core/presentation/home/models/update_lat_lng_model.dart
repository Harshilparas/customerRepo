// To parse this JSON data, do
//
//     final updateLatLngResponseModels = updateLatLngResponseModelsFromJson(jsonString);

import 'dart:convert';

UpdateLatLngResponseModels updateLatLngResponseModelsFromJson(String str) =>
    UpdateLatLngResponseModels.fromJson(json.decode(str));

String updateLatLngResponseModelsToJson(UpdateLatLngResponseModels data) =>
    json.encode(data.toJson());

class UpdateLatLngResponseModels {
  // bool response;
  String message;
  String type;
  dynamic latitude;
  dynamic longitude;

  UpdateLatLngResponseModels({
    // required this.response,
    required this.message,
    required this.type,
    required this.latitude,
    required this.longitude,
  });

  factory UpdateLatLngResponseModels.fromJson(Map<String, dynamic> json) =>
      UpdateLatLngResponseModels(
        // response: json["Response"],
        message: json["message"],
        type: json["type"],
        latitude: double.tryParse(json["Latitude"]),
        longitude: double.tryParse(json["Longitude"]),
      );

  Map<String, dynamic> toJson() => {
        // "Response": response,
        "message": message,
        "type": type,
        "Latitude": latitude,
        "Longitude": longitude,
      };
}
