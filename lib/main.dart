import 'dart:async';

import 'package:sip_social/app/routes/setup_routes.router.dart';
import 'package:sip_social/app/setup_bottomsheet.dart';
import 'package:sip_social/app/setup_dialog.dart';
import 'package:sip_social/app/setup_snackbar.dart';
import 'package:sip_social/const/app_const.dart';
import 'package:sip_social/styles/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sip_social/ui/screens/main/fragments/upload_image_view.dart';
import 'package:sized_context/sized_context.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';
import 'config/theme_config.dart';

void main() {
  runZonedGuarded(() {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
      setupLocator();
      setUpBottomSheet();
      setupSnackBarUi();
      setupDialogUi();

      if (kDebugMode) {
        print("APP Started");
      }
      runApp(const MyApp());
      FlutterNativeSplash.remove();
    });
  }, (error, trace) async {
    if (kDebugMode) {
      print("Error in running the app : $error");
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static AppStyle _style = AppStyle();

  static AppStyle get style => _style;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Main View Building");
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConst.appName,
      navigatorKey: StackedService.navigatorKey,
      builder: EasyLoading.init(
        builder: (context, child) {
          _style = AppStyle(screenSize: context.sizePx);
          return child!;
        },
      ),
      onGenerateRoute: StackedRouter().onGenerateRoute,
      initialRoute: Routes.startUpView,
      theme: ThemeConfig().themeData,
    );
  }
}

AppStyle get $styles => MyApp.style;
