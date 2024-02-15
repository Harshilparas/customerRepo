import 'dart:convert';

import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:http/http.dart' as http;

class DirectionHelper {
  final client = http.Client();
  final googleApiKey = "AIzaSyAEcqthk6N17_4Q3pyqDrKAQPpiYURZxJs";

  Future<List<PointLatLng>> getRouteBetweenCoordinates(double originLat,
      double originLong, double destLat, double destLong) async {
    List<PointLatLng> polylinePoints = [];
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$originLat,$originLong&destination=$destLat,$destLong&mode=driving&avoid=tolls&key=$googleApiKey";

    var response = await http.get(Uri.parse(url));
    try {
      Dev.log(response.body.toString());
      if (response.statusCode == 200) {
        final data=json
            .decode(response.body);
        if((data["routes"] as List).isNotEmpty) {
          polylinePoints = decodeEncodedPolyline(data["routes"][0]["overview_polyline"]["points"]);
        }
      }
    } catch (error,t) {
      Dev.log("getRouteBetweenCoordinates===>$error");
      Dev.log("getRouteBetweenCoordinates===>$t");
    }
    // print(polylinePoints);
    return polylinePoints;
  }

  List<PointLatLng> decodeEncodedPolyline(String encoded) {
    List<PointLatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      PointLatLng p =
      PointLatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }
}

class PointLatLng {
  /// Creates a geographical location specified in degrees [latitude] and
  /// [longitude].
  ///
  const PointLatLng(double latitude, double longitude)
      : latitude = latitude,
        longitude = longitude;

  /// The latitude in degrees.
  final double latitude;

  /// The longitude in degrees
  final double longitude;

  @override
  String toString() {
    return "lat: $latitude / longitude: $longitude";
  }
}