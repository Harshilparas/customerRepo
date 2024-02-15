import 'dart:convert';
import 'dart:math';

import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/presentation/payment_method/model/card_model.dart';
import '../../core/presentation/payment_method/model/coupon_model.dart';

class SharedPreferencesManager extends ChangeNotifier {
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._internal();
  late SharedPreferences _prefs;

  SharedPreferencesManager._internal();

  factory SharedPreferencesManager() {
    return _instance;
  }

  String? _accessToken;
  String? _chatToken;
  String? _userId;
  bool? _islogin;
  String? _deviceToken;
  dynamic _stripeCustomerId;
  dynamic _setupIntent;
  dynamic _ephemerakey;
  dynamic _startTime;
  dynamic _endTime;


  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _accessToken = await getToken();
    _chatToken = await getChatToken();
    _deviceToken = await getDeviceToken();
    _userId = await getUserId();
    _islogin = await getIsLogin();
    _stripeCustomerId = await getIsStripeCustomerId();
    _setupIntent = await getSetupInetent();
    _ephemerakey = await getEphemerakey();
    _startTime = await getStartTime();
    _endTime = await getEndTime();
  }

  String get token => _accessToken??"";

  String get chatToken => _chatToken??"";

  String get userId => _userId??"";

  bool get isLogin => _islogin!;

  String get deviceToken => _deviceToken!;

  dynamic get stripecustomerid => _stripeCustomerId!;

  dynamic get setupintent => _setupIntent??"";

  dynamic get ephemeraKey => _ephemerakey!;

  dynamic get startTime => _startTime??"";

  dynamic get EndTime => _endTime??"";

  
  
//===endTime  time  ===//
  Future<void> setEndTime(String value) async {
    await _prefs.setString("EndTime ", value);
    Dev.log("=========> set EndTime  $value");
    _endTime = value;
    notifyListeners();
  }

//===start time  ===//
  Future<void> setStartTime(String value) async {
    await _prefs.setString("startTime", value);
    Dev.log("=========> set Start time  $value");
    _startTime = value;
    notifyListeners();
  }

//===method for styripe customer id ===//
  Future<void> setStripeCustomerId(String value) async {
    await _prefs.setString("StripeCustomerId", value);
    Dev.log("=========> set stripe id $value");
    _stripeCustomerId = value;
    notifyListeners();
  }

//==========set order id -=======//
  Future<void> setorderId(String value) async {
    await _prefs.setString("orderId", value);
    Dev.log("===========> set order id $value");
    notifyListeners();
  }

  Future<void> removeOrderID() async {
    await _prefs.remove("orderId");
    Dev.log("orderId ======removed");
    notifyListeners();
  }

//===method for styripe customer id ===//
  Future<void> setStripeSetupIntent(String value) async {
    await _prefs.setString("StripeSetIntent", value);
    Dev.log("=========> setupIntent id $value");
    _setupIntent = value;
    notifyListeners();
  }

//===method for styripe customer id ===//
  Future<void> setStripeEphemeralkey(String value) async {
    await _prefs.setString("ephemeralKey", value);
    Dev.log("=========> ephemeralKey id $value");
    _ephemerakey = value;
    notifyListeners();
  }
  CardDetail? getCardDetail() {
    String? userJson = _prefs.getString('paymentCard');
    if (userJson != null) {
      return CardDetail.fromJson(json.decode(userJson));
    }
    return null;
  }
  Future<void> saveCardDetail(CardDetail cardDetail) async {
    String userJson = json.encode(cardDetail.toJson());
   await _prefs.setString('paymentCard', userJson);
  }
  Coupons? getCoupons() {
    String? userJson = _prefs.getString('Coupons');
    if (userJson != null) {
      return Coupons.fromJson(json.decode(userJson));
    }
    return null;
  }
  Future<void> saveCoupons(Coupons cardDetail) async {
    String userJson = json.encode(cardDetail.toJson());
   await _prefs.setString('Coupons', userJson);
  }
  Future<void> removeCoupon() async {
   await _prefs.remove('Coupons');
  }

  // Todo: method to set the token
  Future<void> setToken(String value) async {
    await _prefs.setString("token", value);
    Dev.log("----> Set Token $value");
    _accessToken = value;
    notifyListeners();
  }

//method for set FCM token
  Future<void> setDeviceToken(String value) async {
    await _prefs.setString('deviceToken', value);
    Dev.log("----DeviceToken{value}");
    _deviceToken = value;
    notifyListeners();
  }

  // Todo: method to set the chat token
  Future<void> setChatToken(var value) async {
    await _prefs.setString("chatToken", value);
    Dev.log("----> Set Token $value");
    _chatToken = value;
    notifyListeners();
  }

  // Todo: method to set the User Id
  Future<void> setUserId(String value) async {
    await _prefs.setString("userId", value);
    Dev.log("----> Set Token $value");
    _userId = value;
    notifyListeners();
  }

  // Todo: method to maintain login session
  Future<void> seIsLogin(bool value) async {
    await _prefs.setBool('isLogin', value);
    Dev.log("----> Set Token $value");
    _islogin = value;
    notifyListeners();
  }




  /// method to get the token
  Future<bool> getIsLogin() async {
    _islogin = _prefs.getBool("isLogin");
    Dev.log(_islogin);
    notifyListeners();
    return _prefs.getBool("isLogin") ?? false;
  }

  /// method to get the token
  Future<String> getIsStripeCustomerId() async {
    _stripeCustomerId = _prefs.getString("StripeCustomerId");
    Dev.log(_stripeCustomerId);
    notifyListeners();
    return _prefs.getString("StripeCustomerId") ?? "";
  }

  //========get order id ========//
  String getOrderId() {
    final order = _prefs.getString("orderId") ?? "";
    Dev.log("order=====>$order");
    return order;
  }

  /// method to get the token
  Future<String> getSetupInetent() async {
    _setupIntent = _prefs.getString("StripeSetIntent");
    Dev.log(_setupIntent);
    notifyListeners();
    return _prefs.getString("StripeSetIntent") ?? "";
  }

    /// method to get the token
  Future<String> getStartTime() async {
    _setupIntent = _prefs.getString("startTime");
    Dev.log(_startTime);
    notifyListeners();
    return _prefs.getString("startTime") ?? "";
  }


    /// method to endTime 
  Future<String> getEndTime() async {
    _setupIntent = _prefs.getString("EndTime");
    Dev.log(_endTime);
    notifyListeners();
    return _prefs.getString("EndTime") ?? "";
  }

  /// method to get the token
  Future<String> getEphemerakey() async {
    _ephemerakey = _prefs.getString("ephemeralKey");
    Dev.log(_ephemerakey);
    notifyListeners();
    return _prefs.getString("ephemeralKey") ?? "";
  }

  /// method to get the token
  Future<String> getToken() async {
    _accessToken = _prefs.getString("token");
    Dev.log(_accessToken);
    notifyListeners();
    return _prefs.getString("token") ?? "";
  }

  ///method to get deviceToken
  Future<String> getDeviceToken() async {
    _deviceToken = _prefs.getString('deviceToken');
    Dev.log("---$_deviceToken");
    notifyListeners();
    return _prefs.getString('deviceToken') ?? "";
  }

  /// method to get the token
  Future<String> getUserId() async {
    _userId = _prefs.getString("userId");
    Dev.log(_accessToken);
    notifyListeners();
    return _prefs.getString("userId") ?? "";
  }

  /// method to get the chat token
  Future<String> getChatToken() async {
    _chatToken = _prefs.getString("chatToken");
    Dev.log(_accessToken);
    notifyListeners();
    return _prefs.getString("chatToken") ?? "";
  }

  // Methods to get and set values in SharedPreferences
  String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  Future<bool> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  // Add more methods for other data types as needed

  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  // Clear all stored data in SharedPreferences
  Future<void> clear() {
    return _prefs.clear();
  }
}
