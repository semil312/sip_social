// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sip_social/app/locator.dart';
import 'package:sip_social/app/routes/setup_routes.router.dart';
import 'package:sip_social/const/app_const.dart';
import 'package:sip_social/const/enums/bottom_sheet_enums.dart';
import 'package:sip_social/const/enums/snackbar_enum.dart';
import 'package:sip_social/data/network/api_service/user_api_service.dart';
import 'package:sip_social/data/prefs/shared_preference_service.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/utils/app_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomBaseViewModel extends BaseViewModel {
  NavigationService getNavigationService() => locator<NavigationService>();

  BottomSheetService getBottomSheetService() => locator<BottomSheetService>();

  DialogService getDialogService() => locator<DialogService>();

  SnackbarService getSnackBarService() => locator<SnackbarService>();

  AppUtils getAppUtils() => AppUtils();

  // //region FIREBASE-SERVICE
  // FirebaseNotificationService getNotificationService() =>
  //     locator<FirebaseNotificationService>();
  //
  // FirebaseAuthService getAuthService() => locator<FirebaseAuthService>();
  //
  // FirebaseAnalyticsService getAnalyticsService() =>
  //     locator<FirebaseAnalyticsService>();
  //
  // FirebaseDynamicLinkService getFirebaseDynamicLinkService() =>
  //     locator<FirebaseDynamicLinkService>();
  //endregion

  //region SHARED-PREFERENCE-SERVICE
  SharedPreferenceService getSharedPreferenceService() => locator<SharedPreferenceService>();

  //endregion

  //region API-SERVICE
  UserApiService getUserApiService() => locator<UserApiService>();

  //endregion

  showProgressBar({String title = "Please wait..."}) {
    EasyLoading.show(status: title);
  }

  showEasySuccess({String title = "Please wait..."}) {
    EasyLoading.showSuccess(title);
  }

  showEasyFailure({String title = "Please wait..."}) {
    EasyLoading.showError(title);
  }

  stopProgressBar() {
    EasyLoading.dismiss();
  }

  showSnackBar(String message, {Function? onTap}) {
    Duration toastDuration = const Duration(seconds: 2);

    if (AppUtils().isAndroid()) {
      getSnackBarService().showCustomSnackBar(
        variant: SnackBarEnum.simpleSnackBar,
        message: message,
        duration: toastDuration,
        onTap: (_) {
          if (onTap != null) {
            onTap();
          }
        },
      );
    } else {
      EasyLoading.showToast(message, duration: toastDuration, maskType: EasyLoadingMaskType.clear);
    }
  }

  showSuccessSnackBar(String message, {Duration? duration}) {
    Duration toastDuration = duration ?? const Duration(milliseconds: 1200);
    getSnackBarService().showCustomSnackBar(variant: SnackBarEnum.successSnackBar, message: message, duration: toastDuration, onTap: () {});
  }

  showErrorSnackBar(String message, {Duration? duration}) {
    Duration toastDuration = duration ?? const Duration(milliseconds: 2200);
    getSnackBarService().showCustomSnackBar(variant: SnackBarEnum.errorSnackBar, message: message, duration: toastDuration, onTap: () {});
  }

  showWarningSnackBar(String message, {Duration? duration}) {
    Duration toastDuration = duration ?? const Duration(milliseconds: 2200);
    getSnackBarService().showCustomSnackBar(variant: SnackBarEnum.warningSnackBar, message: message, duration: toastDuration, onTap: () {});
  }

  logout({bool shouldRedirectToAuthenticationPage = true, bool shouldShowDialog = false}) async {
    DialogResponse? dialogResponse;

    if (shouldShowDialog) {
      dialogResponse = await getDialogService().showDialog(
          title: "Logout?", description: "Would you like to log out of your account", cancelTitle: 'Cancel', buttonTitleColor: $styles.colors.white, cancelTitleColor: $styles.colors.white);
    } else {
      dialogResponse = DialogResponse(confirmed: true);
    }

    if (dialogResponse!.confirmed) {
      showProgressBar();
      // await resetApp();
      // await getAuthService().logOut();
      await resetLocator();

      stopProgressBar();
      if (shouldRedirectToAuthenticationPage) {
        getNavigationService().clearStackAndShow(Routes.authView);
      }
    } else {
      return false;
    }
  }

  showErrorDialog({String title = "Problem occurred", String description = "Some problem occurred Please try again", bool isDismissible = true}) async {
    stopProgressBar();

    if (AppUtils().isAndroid()) {
      await getBottomSheetService().showCustomSheet(
        title: title,
        description: description,
        mainButtonTitle: "OK",
        variant: BottomSheetEnum.error,
        barrierDismissible: isDismissible,
      );
    } else {
      getDialogService().showDialog(
        title: title,
        description: description,
        barrierDismissible: isDismissible,
        buttonTitleColor: $styles.colors.white,
      );
    }
  }

  gotoStartUpScreen() {
    resetLocator();
    getNavigationService().clearStackAndShow(Routes.startUpView);
  }

  goToPreviousScreen() {
    getNavigationService().back();
  }

  resetLocator() async {
    await locator.reset(dispose: true);
    setupLocator();
  }

  Future launchLink(String? url) async {
    if (url == null) {
      return;
    }

    try {
      if (!await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication,
      )) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      showErrorSnackBar("Some problem occurred while opening link. Please try again later.");
    }
  }

  Future<void> askLocationPermission(Function() navigate) async {
    LocationPermission permission = await Geolocator.checkPermission();
    try {
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest,
        );
        navigate();
      }
      notifyListeners();
    } catch (e) {
      log("getCurrentPosition $e");
      showErrorSnackBar("Something went wrong");
    }
  }

  Future<bool> askNotificationPermission(Function() navigate) async {
    try {
      PermissionStatus permission = await Permission.notification.status;
      if (permission == PermissionStatus.granted) {
        navigate();
        return true;
      }

      if (permission == PermissionStatus.denied) {
        await Permission.notification.request();
        return false;
      }

      return (await Permission.notification.status) == (PermissionStatus.granted);
    } catch (e) {
      print("askNotificationPermission $e");
      rethrow;
    }
  }

  Future<bool> askPhotosPermission({String? title, String? description}) async {
    if (AppUtils().isAndroid()) {
      return askAndroidPhotoPermission();
    } else {
      return askIOSPhotoPermission();
    }
  }

  Future<bool> askCameraPermission({String? title, String? description}) async {
    if (AppUtils().isAndroid()) {
      return askAndroidCameraPermission();
    } else {
      return askIOSCameraPermission();
    }
  }

  Future<bool> askAndroidPhotoPermission({String? title, String? description}) async {
    bool permissionGranted = false;
    bool shouldShowRationalBefore = await Permission.storage.shouldShowRequestRationale;
    PermissionStatus permissionStatus = await Permission.storage.request();
    if (permissionStatus == PermissionStatus.granted) {
      permissionGranted = true;
    } else {
      bool shouldShowRationalAfter = await Permission.storage.shouldShowRequestRationale;
      if (shouldShowRationalBefore == shouldShowRationalAfter) {
        DialogResponse? dialogResponse = await getDialogService().showDialog(
            title: title ?? '${AppConst.appName} would like to access your photos',
            description: description ?? 'Allows “${AppConst.appName}” to access your photos so you can select photos',
            cancelTitle: 'Cancel',
            buttonTitleColor: $styles.colors.white,
            cancelTitleColor: $styles.colors.white);

        if (dialogResponse != null && dialogResponse.confirmed) {
          await openAppSettings();
        } else {
          permissionGranted = false;
        }
      }
    }
    return permissionGranted;
  }

  Future<bool> askAndroidCameraPermission({String? title, String? description}) async {
    bool permissionGranted = false;
    bool shouldShowRationalBefore = await Permission.camera.shouldShowRequestRationale;
    PermissionStatus permissionStatus = await Permission.camera.request();
    if (permissionStatus == PermissionStatus.granted) {
      permissionGranted = true;
    } else {
      bool shouldShowRationalAfter = await Permission.camera.shouldShowRequestRationale;
      if (shouldShowRationalBefore == shouldShowRationalAfter) {
        DialogResponse? dialogResponse = await getDialogService().showDialog(
            title: title ?? '${AppConst.appName} would like to access your camera',
            description: description ?? 'Allows “${AppConst.appName}” to access your camera so you can take picture',
            cancelTitle: 'Cancel',
            buttonTitleColor: $styles.colors.white,
            cancelTitleColor: $styles.colors.white);

        if (dialogResponse != null && dialogResponse.confirmed) {
          await openAppSettings();
        } else {
          permissionGranted = false;
        }
      }
    }
    return permissionGranted;
  }

  Future<bool> askIOSPhotoPermission({String? title, String? description}) async {
    bool permissionGranted = false;
    PermissionStatus permissionStatus = await Permission.photos.status;

    if (permissionStatus == PermissionStatus.granted) {
      permissionGranted = true;
    } else if (permissionStatus == PermissionStatus.denied) {
      PermissionStatus permissionStatus = await Permission.photos.request();
      permissionGranted = (permissionStatus == PermissionStatus.granted);
    } else {
      print("permission : ");

      DialogResponse? dialogResponse = await getDialogService().showDialog(
        title: title ?? '${AppConst.appName} would like to access your photos',
        description: description ?? 'Allows “${AppConst.appName}” to access your photos so you can share your folders',
        cancelTitle: 'Cancel',
        buttonTitleColor: $styles.colors.white,
        cancelTitleColor: $styles.colors.white,
      );

      if (dialogResponse != null && dialogResponse.confirmed) {
        await openAppSettings();
      } else {
        permissionGranted = false;
      }
    }

    return permissionGranted;
  }

  Future<bool> askIOSCameraPermission({String? title, String? description}) async {
    bool permissionGranted = false;
    PermissionStatus permissionStatus = await Permission.camera.status;

    if (permissionStatus == PermissionStatus.granted) {
      permissionGranted = true;
    } else if (permissionStatus == PermissionStatus.denied) {
      PermissionStatus permissionStatus = await Permission.camera.request();
      permissionGranted = (permissionStatus == PermissionStatus.granted);
    } else {
      DialogResponse? dialogResponse = await getDialogService().showDialog(
        title: title ?? '${AppConst.appName} would like to access your camera',
        description: description ?? 'Allows “${AppConst.appName}” to access your camera so you can share your folders',
        cancelTitle: 'Cancel',
        buttonTitleColor: $styles.colors.white,
        cancelTitleColor: $styles.colors.white,
      );

      if (dialogResponse != null && dialogResponse.confirmed) {
        await openAppSettings();
      } else {
        permissionGranted = false;
      }
    }

    return permissionGranted;
  }

  resetApp() async {
    await getSharedPreferenceService().clearSharedPreference();
    // await getNotificationService().resetBadgeCount();
    // await getNotificationService().cancelAllNotifications();
    // await getNotificationService().deleteInstanceId();
  }
}
