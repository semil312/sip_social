import 'package:sip_social/ui/screens/authentication/auth_view.dart';
import 'package:sip_social/ui/screens/how_it_works/how_it_works_view.dart';
import 'package:sip_social/ui/screens/main/main_view.dart';
import 'package:sip_social/ui/screens/onboarding_screen/onboarding_view.dart';
import 'package:sip_social/ui/screens/profile/profile_view.dart';
import 'package:sip_social/ui/screens/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartUpView, initial: true),
    MaterialRoute(page: OnBoardingView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: HowItWorksView),
    MaterialRoute(page: MainView),
    MaterialRoute(page: ProfileView),
  ],
)
class AppSetup {}
