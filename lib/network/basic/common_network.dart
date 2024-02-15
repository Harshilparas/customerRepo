import 'dart:convert';
import 'dart:io';

import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ApiService {
  static final ApiService _apiService = ApiService.internal();

  factory ApiService() {
    return _apiService;
  }

  ApiService.internal();

  // Post Method

  Future<dynamic> callPostApi(
    Map<String, dynamic>? body,
    String endPoint, {
    String token ="" ,
    bool isFullUrl = false,
    bool isPlain = false,
  }) async {
    try {
      Dev.log(
          'URL Request ------------------------------->\n ${NetworkConstant.baseUrl}$endPoint');
      Dev.log(
          'API Request ------------------------------->\n ${body.toString()}');

      ///Create a map to send in the header
        // "Content-Type": "application/json",
      final withToken= !isPlain ?
          {"Content-Type": "application/json", "Authorization": 'Bearer ${token.isNotEmpty?token:SharedPreferencesManager().token}'}
           :
         {"Content-Type": "text/plain", "Authorization": 'Bearer ${token.isNotEmpty?token:SharedPreferencesManager().token}'};

      Dev.log(
          'API Request Header ------------------------------->\n ${jsonEncode(withToken)}');

      ///Merge the url
      String url = isFullUrl ? endPoint : '${NetworkConstant.baseUrl}$endPoint';

      ///Call the post API call
      final response = await http.post(
        Uri.parse(url),
        headers: withToken,
        // body: body.toString(),
        body: !isPlain?jsonEncode(body):body.toString(),
      );
      Dev.log(
          'API response ------------------------------->\n ${response.statusCode}');
      String finalResponse = response.body;
      Dev.log(
          'API final response ------------------------------->\n ${finalResponse.toString()}');

      ///return the response data
      final data = jsonDecode(finalResponse);

      return data;
    } catch (e) {
      Dev.log(e.toString());
    }
  }

  // Upload Image
  Future<dynamic> uploadFile(File image) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${SharedPreferencesManager().token}'};
      // Url

      String url = '${NetworkConstant.baseUrl}${NetworkConstant.uploadFileEndpoint}';
      Dev.log(url);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files
          .add(await http.MultipartFile.fromPath('upload', image.path));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      Dev.log('-----> ${response.statusCode}');
      if (response.statusCode == 200) {
        var resp = await response.stream.bytesToString();
        Dev.log(resp);
        return jsonDecode(resp);
      } else {
        // Error
        Dev.log('-----> ${response.reasonPhrase}');
      }
    } catch (e) {
      Dev.log('---> Execption ${e.toString()}');
    }
  }

  /// Call get  api
  ///

  Future<dynamic> callGetApi(String endPoint, {String token = ''}) async {
    try {
      Dev.log(
          'URL Request ------------------------------->\n ${NetworkConstant.baseUrl}/$endPoint');

      Dev.log('token ------------------>\n $token');
      final response = await http.get(
         
        Uri.parse('${NetworkConstant.baseUrl}$endPoint'),
    
        headers: {
          // "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      String finalResponse = response.body;
      Dev.log(
          'endPoint API request header ------------------>\n ${response.headers}');
      Dev.log('endPoint API response $endPoint------------------>\n $finalResponse');
      return jsonDecode(finalResponse);
    } catch (e) {
      Dev.log('----->execption: $e');
    }
  }

  Future<dynamic> callGetApiThirdParty({required String input}) async {
    try {
    //  String kPLACES_API_KEY = "AIzaSyAEcqthk6N17_4Q3pyqDrKAQPpiYURZxJs";
      String kPLACES_API_KEY = "AIzaSyDiKTQ48lMBMLemXjAbEPbw8GwaVzPoNyo";
   //   String kPLACES_API_KEY = "AIzaSyAEcqthk6N17_4Q3pyqDrKAQPpiYURZxJs";

      String type = "(regions)";
      String baseURL =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json";
      String request =
          "$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=${Uuid().v4()}";

      print("request====> ${request}");
      var response = await http.get(Uri.parse(request));

      return response;
    } catch (e) {
      Dev.log('----->execption: $e');
    }
  }
}
