class AppStrings {
  static final AppStrings _appStrings = AppStrings.internal();

  factory AppStrings() {
    return _appStrings;
  }

  AppStrings.internal();

  //[@LOGIN_STRINGS]
  static const String loginHeading = "Welcome back!";
  static const String loginSubHeading =
      'Please enter your email and password to login ';

  static const String email = "Email";
  static const String password = "Password";
  static const String forgotPassword = 'Forgot password?';
  static const String login = 'Login';
  static const String orLoginWith = 'Or login with';
  static const String loginWithFacebook = 'Login with Facebook';
  static const String notMember = 'Not a member? Sign up';
  static const String skipNow = 'Skip for now';

  //[@SIGNUP_STRING]
  static const String signupHeading = 'Let’s get started';
  static const String signupSubHeading =
      'Create an account to DeRyde to enjoy the ride';
  static const String confirmPass = 'Confirm password';
  static const String NoDataFound = 'No Data Found';
  static const String checkcupons = 'Apply Coupon';
  static const String byCreating = 'By creating an account. you agree to ';
  static const String termService = 'Terms of Service ';
  static const String policy = 'Privacy Policy';
  static const String signup = 'Sign up';
  static const String alreadyMember = 'Already a member? Sign in';

  //[@FORGOT_PASS_STRING]
  static const String forgotPass = "Forgot password";
  static const String forgotPassSubHeading =
      'Enter your official email to get a verification code.';
  static const String submit = 'Submit';

  //[@OTP_VERIFICATION_STRING]
  static const String otpVerification = 'OTP Verification';
  static const String otpVerificationSubHeading =
      'We have sent the code verification to your ';
  static const String verify = 'Verify';
  static const String doNotReceiveCode = 'Don’t receive OTP code ? ';
  static const String resendCode = 'Resend Code';

  //[@RESET_PASSWORD]
  static const String resetPassHeading = 'Reset password';
  static const String resetPassSubHeading =
      'At least 8 characters, with uppercase and lowercase letters';
  static const newPass = 'New Password';

  //[@CREATE_PROFILE]
  static const String createProfile = 'Create profile';
  static const String personalDetails = 'Personal Details';
  static const String vehicleDetails = 'Vehicle Details';
  static const String bankDetails = 'Bank Details';
  static const String uploadProfile = 'Upload profile ';
  static const String firstName = 'First name';
  static const String lastName = 'Last name';
  static const String mobileNumber = 'Mobile number';
  static const String country = 'Country';
  static const String uploadDrivingLicence = 'Upload Driving Licence ';
  static const String uploadIdProof = 'Upload ID Proof';
  static const String uploadOtherDocument = 'Upload Other Documents';
  static const String uploadVechileInsurance = 'Upload  Vehicle insurance';
  static const String uploadVechileCertification =
      'Upload Vehicle certification';
  static const String uploadProofOfWork = 'Upload Proof of Work Eligibility';
  static const String uploadFrontImage = 'Upload Front Image';
  static const String uploadBackImage = 'Upload Back Side Image';

  static const String continues = 'Continue';
  static const String vechileType = 'Vehicle type';
  static const String vechileNumber = 'Vehicle Number';
  static const String vechileName = 'Vehicle Name';
  static const String vechileModel = 'Vehicle Model';
  static const String insuranceNumber = 'Insurance Number';
  static const String bankName = 'Bank Name';
  static const String accountNumber = 'Account Number';
  static const String accountHolderName = 'Account Holder Name';
  static const String ifscCode = 'IFSC Code';
  static const String institutionNumber = 'Institution number';
  static const String transitNumber = 'Transit number';
  static const String online = 'Online';
  static const String offline = 'Offline';
  static const String waiting = 'Waiting!';
  static const String pleaseWaitForReside =
      'Please wait for the resides\n to come.';

  //[@Setting]
  static const String setting = "Settings";
  static const String editProfile = 'Edit Profile';
  static const String contactUs = 'Contact us';
  static const String privacyPolicy = 'Privacy policy';
  static const String termCondition = 'Terms and Conditions';
  static const String logout = 'Log out';
  static const String save = 'Save';
  static const String getInTouch = 'Get in touch';
  static const String haveAnyQues =
      'Hove any questions? We’d love to hear from you.';
  static const String cancelRide = 'Cancel ride';

  static const String sendMessage = 'Send message';
  static const String messageSent = 'Message Sent';
  static const String yourMessageSent = 'Your message has been sent';
  static const String done = 'Done';
  static const String confirm = 'Confirm';

  //[@HOME_REQUEST]
  static const String totalFare = 'Total Fare';
  static const String reject = 'Reject';
  static const String accept = 'Accept';
  static const String cancel = 'Cancel';
  static const String rechedPickupLocation = 'Reached Pickup Location';
  static const String startTrip = 'Start Trip';
  static const String endTrip = 'End Trip';
  static const String receipt = 'Receipt';
  static const String paymentSCreen = 'Payment Screen';
  static const String goOnline = "Go Online!";
  static const String youAreCurrentlyOffline =
      'You are currently offlinego online to get rides.';
  static const String reasonWhyYouCancelRide =
      'Reasons why you cancel this ride ?';
  static const String wrongLocation = 'Wrong Location';
  static const String gotAFasterRide = 'Got a faster ride';
  static const String anyLegalInstruction = 'Any Legal instructions violation';
  static const String myReasonIsNotListed = 'My reason is not listed';

  static const String editBankDetails = 'Edit Bank Details';
  static const String editVechileDetails = 'Edit Vehicle Details';
  static const String bookNow = 'Book Now';
  static const String nearbyDriverText =
      'We are searching for nearby driver\nfor you';
  static const String pleaseWait = 'Please wait...';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String likeToCancel = 'Would you like to cancel?';

  //[@Receipt]
  static const String fareBreakDown = 'Fare Breakdown';
  static const String rateYourPassenger = 'How was your ride?';
  static const String yourFeedBackWillWork =
      'Your feedback will help improve \ndriving experience';
  static const String skip = 'Skip';
  static const String ratingSubmitted = 'Rating Submitted';
  static const String yourRatingHasSubmitted = 'Your Rating has been submitted';
  static const String requestHistory = 'Request History';
  static const String rideType = 'Ride Type';

  //[@HIstory]
  static const String tripDetails = 'Trip Details';
  static const String pickupLocation = 'Pickup ';
  static const String dropLocation = 'Drop-off';
  static const String card = 'Card';
  static const String ratingGiven = 'Rating Given';
  static const String ratingReceived = 'Rating Received';
  static const String dummyComt =
      "Very Continent ride and really nice driver behaviour. Quick service really enjoyed the ride.";
  static const String history = 'History';

  //[@Chat]
  static const String activeNow = "Active now";

  //[@ErrorMsg]
  static const String emailErrorMsgEmpty = 'Enter Email Address';
  static const String emailErrorMsg = 'Invalid Email Address';
  static const String passwordErrorMsgEmpty = 'Enter Password';
  static const String confirmPasswordErrorMsgEmpty = 'Re-Enter Password';
  static const String passDontMatch =
      'Password and confirm password doesn’t match';
  static const String termsError = 'Please Accept Terms and Condition';
  static const String firstNameError = 'Enter First Name';
  static const String lastNameError = 'Enter Last Name';
  static const String mobileNumberError = 'Enter Mobile Number';

  /// bank details error msg
  static const String bankNameError = 'Enter Bank Name';
  static const String accountNumberError = 'Enter Account Number';
  static const String accountHolderNameErro = 'Enter Account Holder Name ';
  static const String institutionNumberError = "Enter Institution number";
  static const String transitNumberError = 'Enter Transit number';

  /// payment method string
  static const String paymentMethod = 'Payment Method';
  static const String debitandCreditCard = 'Debit/Credit Card';
  static const String applePay = 'Apple Pay';
  static const String googlePay = 'Google Pay';
  static const String addNewCard = 'Add New Card';
  static const String add = 'Add';
  static const String payment = 'Payment';
  static const String toPay = 'Payment with card';
  static const String applyCoupon = 'Apply Coupon';
 
  static const String apply = 'Apply';
  static const String checkCoupon = 'Check Coupon';
  static const String message = 'Message';
  static const String callNow = 'Call now';
  static const String backToHome = 'Back to home';
  static const String baseFare = "Base Fare";
  static const String techFare = "Tech Fare";
  static const String perKm = "Extra Per Km - C1.10 Per Km";
  static const String perMin = "Extra Per Min - CO.30 Per Minute";
  static const String tip = "Tip";
  static const String totalPrice = "Total Price";
  static const String date = "Date";
  static const String addTip = "Add tip";
  static const String time = "Time";
  static const String totalDistance = "Total Distance";
  static const String timeToken = "Time Taken";
  static const String ratings = "Ratings";

  /// rating

  static const String basedOn20Reviews = 'Based On';
  static const String review =
      'Lorem ipsum dolor sit amet consectetur. Scelerisque ornare nunc adipiscing ipsum id turpis quis. Viverra amet arcu eget quisque cras risus lacus tristique morbi. Nisl magnis aliquam tortor dui adipiscing .';

  /// rate us
  static const String howWasRide = 'How was your ride?';
  static const String yourFeedbackWill = 'Your feedback will help improve';
  static const String drivingExperience = 'driving experience';
  static const String additionalComments = 'Additional comments...';

  static const String passShouldContain =
      'Password 8 character,Numbers,1 Capital letter and small letter and character';
}
