import 'dart:developer';
import 'dart:io';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sip_social/base/custom_base_view_model.dart';

class MainViewModel extends CustomBaseViewModel {
  String dobErrorText = '';
  String? countryCode;
  int currentIndex = 0;
  int currentIndexOfNameDOBZipCodeView = 0;
  File? image;
  bool isDOBValidate = true;

  PageController pageController = PageController();

  ScrollController mobileNumberEmailViewScrollController = ScrollController();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  TextEditingController nameDOBZipcodeNameController = TextEditingController();
  TextEditingController nameDOBZipcodeDayController = TextEditingController();
  TextEditingController nameDOBZipcodeMonthController = TextEditingController();
  TextEditingController nameDOBZipcodeYearController = TextEditingController();
  TextEditingController nameDOBZipcodeZipcodeController = TextEditingController();

  TextEditingController bioController = TextEditingController();
  TextEditingController choiceOfDrinkController = TextEditingController();

  GlobalKey<FormState> mobileEmailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> nameDOBZipcodeFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> bioFormKey = GlobalKey<FormState>();

  init() async {
    await CountryCodes.init();
    countryCode = await getAppUtils().getCountryCodeOfThisDevice();
    notifyListeners();
  }

  void setIndex({required int index}) {
    currentIndex = index;
    notifyListeners();
  }

  void setIndexOfNameDOBZipCodeView({required int index}) {
    currentIndexOfNameDOBZipCodeView = index;
    notifyListeners();
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter mobile number";
    }

    if (value.length < 8) {
      return "Please enter valid mobile number";
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "The name should be at least 3 letters";
    }

    if (value.length < 3) {
      return "The name should be at least 3 letters";
    }

    return null;
  }

  validateDOB() {
    try {
      String day = nameDOBZipcodeDayController.text.trim();
      String month = nameDOBZipcodeMonthController.text.trim();
      String year = nameDOBZipcodeYearController.text.trim();

      if (day.isEmpty || month.isEmpty || year.isEmpty) {
        isDOBValidate = false;
        dobErrorText = "DOB is invalid";
        notifyListeners();
        return;
      }

      if (day.length > 2 || month.length > 2 || year.length != 4) {
        isDOBValidate = false;
        dobErrorText = "DOB is invalid";
        notifyListeners();
        return;
      }

      if (int.parse(day) < 1 || int.parse(day) > 31) {
        isDOBValidate = false;
        dobErrorText = "Date is invalid";
        notifyListeners();
        return;
      }

      if (int.parse(month) < 1 || int.parse(month) > 12) {
        isDOBValidate = false;
        dobErrorText = "Month is invalid";
        notifyListeners();
        return;
      }

      if (int.parse(year) < 1900 || int.parse(year) > 2023) {
        isDOBValidate = false;
        dobErrorText = "Year is invalid";
        notifyListeners();
        return;
      }

      DateTime currentDate = DateTime.now();
      DateTime dob = DateTime(int.parse(year), int.parse(month), int.parse(day));
      int age = currentDate.year - dob.year;

      if (currentDate.month < dob.month || (currentDate.month == dob.month && currentDate.day < dob.day)) {
        age--;
      }

      if (age < 21) {
        isDOBValidate = false;
        dobErrorText = "You are under age to join Sipper Social";
        notifyListeners();
        return;
      }

      isDOBValidate = true;
      dobErrorText = "";
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  String? validateZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your zipcode";
    }

    if (value.length < 5) {
      return "The ZIP code you have entered is invalid";
    }

    return null;
  }

  String? validateBio(String? value) {
    if (value == null || value.isEmpty) {
      return "You have to enter a description of at least 100 characters";
    }

    if (value.length < 100) {
      return "You have to enter a description of at least 100 characters";
    }

    return null;
  }

  String? validateChoiceOfDrink(String? value) {
    if (value == null || value.isEmpty) {
      return "The name should be at least 3 letters";
    }

    if (value.length < 3) {
      return "The name should be at least 3 letters";
    }

    return null;
  }

  navigateToAllowNotification() {
    if (!mobileEmailFormKey.currentState!.validate()) return;
    setIndex(index: 1);
  }

  navigateToAllowLocation() {
    setIndex(index: 2);
  }

  navigateToNameDOBZipcodeView() {
    setIndex(index: 3);
  }

  navigateToBioView() {
    // validateDOB();
    // if (!isDOBValidate) return;
    setIndex(index: 4);
  }

  navigateToUploadImageView() {
    // if (!bioFormKey.currentState!.validate()) return;
    setIndex(index: 5);
  }

  navigateToNameDOBZipcodeIntroView() {
    setIndexOfNameDOBZipCodeView(index: 0);
  }

  navigateToNameDOBZipcodeDetailsView() {
    setIndexOfNameDOBZipCodeView(index: 1);
  }

  navigateToSavingProfile() {
    setIndex(index: 6);
  }

  uploadImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();

      final image = await picker.pickImage(source: source);

      if (image == null) {
        return showErrorSnackBar("No Image Selected.");
      }

      final finalImage = File(image.path);

      this.image = finalImage;
      notifyListeners();
      log("Final Image ${finalImage.path}");
      if (finalImage.path.isEmpty) return;
    } on PlatformException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  void maintainTextFieldPosition(double a) {
    mobileNumberEmailViewScrollController.animateTo(
      a,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    notifyListeners();
  }
}
