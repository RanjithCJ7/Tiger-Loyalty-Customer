import 'package:get/get.dart';
import 'package:tl_customer/screens/newUser/controller/brands_newuser.dart';
import 'package:tl_customer/screens/newUser/controller/newuser_controller.dart';
import 'package:tl_customer/screens/newUser/controller/reward_newuser_controller.dart';
import 'package:tl_customer/screens/profile/controller/profile_controller.dart';
import 'package:tl_customer/screens/promo/controller/promo_controller.dart';
import 'package:tl_customer/screens/rewards/controller/rewards_controller.dart';
import 'package:tl_customer/screens/signin/controller/signin_controller.dart';
import 'package:tl_customer/screens/signup/controller/signup_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SigninController());
    Get.lazyPut(() => SignupController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => RewardsController());
    Get.lazyPut(() => PromoController());
    Get.lazyPut(() => NewuserController());
    Get.lazyPut(() => RewardsNewUserController());
    Get.lazyPut(() => BrandsNewUserController());
  }
}
