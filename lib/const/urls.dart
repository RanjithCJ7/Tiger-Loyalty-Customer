class Urls {
  static const String baseUrl = "http://52.51.249.84:8080";

  static const String signIn = "$baseUrl/api/auth/customerSignin";
  static const String validateOTP = "$baseUrl/api/auth/validateOtp";
  static const String sendOTP = "$baseUrl/api/auth/generateOtp";
  static const String signUp = "$baseUrl/api/auth/customerSignup";
  static const String pinSetup = "$baseUrl/api/auth/customerPinSetup";
  static const String uploadProfileImage =
      "$baseUrl/api/app/userProfile/upload-image";
  static const String refreshToken = "$baseUrl/api/auth/refreshToken";
  static const String userProfile = "$baseUrl/api/app/userProfile";
  static const String fetchProfileImage = "$baseUrl/api/app/downloaduserimage";
  static const String changeNumber =
      "$baseUrl/api/app/userProfile/changePhoneNumber";
  static const String changePIN = "$baseUrl/api/app/resetnewpin";
  static const String getRewardDataByBrand =
      "$baseUrl/api/app/getRewardDataByBrand";
  static const String getRewardDataForNonRegister =
      "$baseUrl/api/app/getRewardDataForNonRegister";
  static const String getRewardSummary = "$baseUrl/api/app/getRewardSummary";
  static const String redeemPoints = "$baseUrl/api/app/redeemPoints";
  static const String generateOTPforget =
      "$baseUrl/api/auth/generateOtpforuser";
  static const String validateOtpforget =
      "$baseUrl/api/auth/validateOtpforToken";
  static const String makePayment = "$baseUrl/api/app/makePayment";
  static const String getMerchantDetail = "$baseUrl/api/auth/getMerchantDetail";
  static const String postReview = "$baseUrl/api/app";
  static const String sharePoints = "$baseUrl/api/app/sharePoints";
  static const String notification = "$baseUrl/api/app/notifications";
  static const String readNotification =
      "$baseUrl/api/app/notifications/mark-as-read";
  static const String checkUser = "$baseUrl/api/auth/exists";
  static const String verifyPin = "$baseUrl/api/app/verifyPin";
  static const String getMerchantDetailNonReg =
      "$baseUrl/api/auth/getMerchantDetail";
  static const String makePaymentNonReg =
      "$baseUrl/api/auth/makePaymentWithoutToken";
  static const String saveRewards = "$baseUrl/api/auth/collectRewadsPoints";
  static const String deleteAccount = "$baseUrl/api/app/deleteAccount";
  static const String transactions = "$baseUrl/api/app/transactions";
}
