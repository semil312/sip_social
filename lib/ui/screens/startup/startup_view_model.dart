import 'package:sip_social/app/routes/setup_routes.router.dart';
import 'package:sip_social/base/custom_base_view_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StartUpViewModel extends CustomBaseViewModel {
  runStartupLogic() async {
    await Future.delayed(1.seconds);
    getNavigationService().clearStackAndShow(
      Routes.onBoardingView,
    );
  }
}
