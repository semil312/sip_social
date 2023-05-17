import 'package:flutter/material.dart';
import 'package:sip_social/app/locator.dart';
import 'package:sip_social/const/enums/snackbar_enum.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackBarUi() {
  final service = locator<SnackbarService>();

  service.registerCustomSnackbarConfig(
    variant: SnackBarEnum.simpleSnackBar,
    config: SnackbarConfig(
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        borderRadius: 1,
        snackStyle: SnackStyle.GROUNDED,
        instantInit: true),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackBarEnum.successSnackBar,
    config: SnackbarConfig(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        borderRadius: 1,
        snackStyle: SnackStyle.GROUNDED,
        instantInit: true),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackBarEnum.errorSnackBar,
    config: SnackbarConfig(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        borderRadius: 1,
        snackStyle: SnackStyle.GROUNDED,
        instantInit: true),
  );


  service.registerCustomSnackbarConfig(
    variant: SnackBarEnum.warningSnackBar,
    config: SnackbarConfig(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        borderRadius: 1,
        snackStyle: SnackStyle.GROUNDED,
        instantInit: true),
  );

}
