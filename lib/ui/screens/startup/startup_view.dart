import 'package:sip_social/ui/screens/startup/startup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      onViewModelReady: (StartUpViewModel model) {
        model.runStartupLogic();
      },
      viewModelBuilder: () => StartUpViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Image.asset(
            "assets/images/splash_image.png",
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
