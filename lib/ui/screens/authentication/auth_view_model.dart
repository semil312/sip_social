import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:sip_social/app/routes/setup_routes.router.dart';
import 'package:sip_social/base/custom_base_view_model.dart';

class AuthViewModel extends CustomBaseViewModel {
  String? countryCode;
  String? phoneNumber;

  int currentIndex = 0;

  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  init() async {
    await CountryCodes.init();
    countryCode = await getAppUtils().getCountryCodeOfThisDevice();
    notifyListeners();
  }

  void setIndex({required int index}) {
    currentIndex = index;
    notifyListeners();
  }

  loginUser({required String phoneNumber}) {
    this.phoneNumber = "($countryCode) $phoneNumber";
    notifyListeners();
    if (!phoneFormKey.currentState!.validate()) return;
    setIndex(index: 1);
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter mobile number";
    }

    if (value.length < 10) {
      return "Please enter valid mobile number";
    }

    if (value.length > 10) {
      return "The mobile number is not registered to any account";
    }
    return null;
  }

  String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return "The pin entered is invalid";
    }

    if (value.length < 6) {
      return "The pin entered is invalid";
    }
    return null;
  }

  navigateToHowItWorks() {
    if (!otpFormKey.currentState!.validate()) return;
    getNavigationService().navigateTo(Routes.howItWorksView);
  }

  disposeViewModel() {
    phoneController.dispose();
  }
}
