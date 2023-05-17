import 'dart:io';
import 'dart:math';

import 'package:country_codes/country_codes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:objectid/objectid.dart';
import 'package:sip_social/main.dart';

class AppUtils {
  Future<String?> getCountryCodeOfThisDevice() async {
    final CountryDetails details = CountryCodes.detailsForLocale();
    return details.dialCode;
  }

  String generateUniqueMongoId() {
    final id = ObjectId();
    return id.hexString;
  }

  bool isAndroid() {
    if (Platform.isAndroid) {
      return true;
    } else {
      return false;
    }
  }
  bool isIOS() {
    if (Platform.isIOS) {
      return true;
    } else {
      return false;
    }
  }

  easyLoadingInit() {
    if (isAndroid()) {
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.ring
        ..loadingStyle = EasyLoadingStyle.custom
        ..maskColor = $styles.colors.white
        ..maskType = EasyLoadingMaskType.custom
        ..backgroundColor = $styles.colors.primaryPurpleColor
        ..textColor = $styles.colors.white
        ..indicatorColor = $styles.colors.white
        ..toastPosition = EasyLoadingToastPosition.bottom;
    } else {
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.circle
        ..loadingStyle = EasyLoadingStyle.custom
        ..maskColor = $styles.colors.white
        ..maskType = EasyLoadingMaskType.custom
        ..backgroundColor = $styles.colors.primaryPurpleColor
        ..textColor = $styles.colors.white
        ..indicatorColor = $styles.colors.white
        ..toastPosition = EasyLoadingToastPosition.bottom;
    }
  }

  String getRandomId() {
    var random = Random();
    var id = "";
    for (var i = 0; i < 5; i++) {
      id += random.nextInt(10).toString();
    }

    DateTime dateTime = DateTime.now();

    return "${id}_${dateTime.millisecondsSinceEpoch}";
  }

  bool isValidEmail(String inputMail) {
    inputMail = inputMail.trim();
    if (EmailValidator.validate(inputMail) && inputMail.substring(inputMail.length - 3) == "com") {
      return true;
    } else {
      return false;
    }
  }

  bool isValidLink(String inputLink) {
    inputLink = inputLink.trim();

    if (inputLink.contains(".") && inputLink.startsWith("http")) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidPassword(String inputPassword) {
    if (inputPassword.length >= 8 && inputPassword.length <= 12) {
      return true;
    } else {
      return false;
    }
  }

  bool isNetworkImage(String url) {
    if (url.startsWith("http")) {
      return true;
    } else {
      return false;
    }
  }
}
