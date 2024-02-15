class NetworkConstant {
  static final NetworkConstant _networkConstant = NetworkConstant.internal();

  factory NetworkConstant() {
    return _networkConstant;
  }

  NetworkConstant.internal();

  static const baseUrl =
      "https://php.parastechnologies.in/de-ride/public/api/webservice/";
  static const imageBaseUrl =
      'https://php.parastechnologies.in/de-ride/public/';

  /// Api
  static const signUpEndpoint = 'user_register';
  static const loginEndpoint = 'login';
  static const uploadFileEndpoint = 'customerUpload';
  static const createProfileEndPoint = 'customer/create/profile';
  static const forgotPassEndPoint = 'password/forgot';
  static const verifyOtp = 'otp/verify';
  static const resetPassEndPoint = 'customer/password/reset';
  static const getProfileEndPoint = 'user_profile';
    static const privacyPolicyEndPoint =
      'https://php.parastechnologies.in/de-ride/public/privacy';
  static const termsPolicyEndPoint =
      'https://php.parastechnologies.in/de-ride/public/terms';
        static const contactUsEndPoint = 'contactUs';
        static const priceCategoryVechile = 'priceCategory';
        static const historyOrderUser = 'history_order_user';
        static const orderRating = 'order/rating';
        static const orderReceipt = 'customer/order/receipt';
        static const cardList = 'card/list';
        static const carddetailadd = 'card/detail/add';
        static const ratingList = 'rating/list';
        static const cardDelete = 'card/delete';
        static const getCoupons = 'get/coupons';
        static const rideInProcess = 'getOrder?id=';
        static const payment = 'https://php.parastechnologies.in/de-ride/public/api/webservice/driver/payment';

}
  