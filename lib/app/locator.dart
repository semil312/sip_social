import 'package:sip_social/base/custom_base_view_model.dart';
import 'package:sip_social/ui/screens/authentication/auth_view_model.dart';
import 'package:sip_social/ui/screens/how_it_works/how_it_works_view_model.dart';
import 'package:sip_social/ui/screens/main/main_viewmodel.dart';
import 'package:sip_social/ui/screens/onboarding_screen/onboarding_viewModel.dart';
import 'package:sip_social/ui/screens/profile/profile_view_model.dart';
import 'package:sip_social/ui/screens/startup/startup_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SnackbarService());

  locator.registerLazySingleton(() => StartUpViewModel());
  locator.registerLazySingleton(() => CustomBaseViewModel());
  locator.registerLazySingleton(() => OnBoardingViewModel());
  locator.registerLazySingleton(() => AuthViewModel());
  locator.registerLazySingleton(() => HowItWorksViewModel());
  locator.registerLazySingleton(() => MainViewModel());
  locator.registerLazySingleton(() => ProfileViewModel());
}
