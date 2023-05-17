import 'package:sip_social/app/routes/setup_routes.router.dart';
import 'package:sip_social/base/custom_base_view_model.dart';

class HowItWorksViewModel extends CustomBaseViewModel {
  navigateToMobileNumberEmailView() {
    getNavigationService().navigateToMainView();
  }
}
