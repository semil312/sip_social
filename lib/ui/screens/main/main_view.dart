import 'package:flutter/material.dart';
import 'package:sip_social/app/locator.dart';
import 'package:sip_social/ui/screens/main/fragments/allow_location_view.dart';
import 'package:sip_social/ui/screens/main/fragments/allow_notification_view.dart';
import 'package:sip_social/ui/screens/main/fragments/bio_view.dart';
import 'package:sip_social/ui/screens/main/fragments/email_username_view.dart';
import 'package:sip_social/ui/screens/main/fragments/name_dob_zipcode/personal_details_name_dob_zipcode_view.dart';
import 'package:sip_social/ui/screens/main/fragments/saving_profile_view.dart';
import 'package:sip_social/ui/screens/main/fragments/upload_image_view.dart';
import 'package:sip_social/ui/screens/main/main_viewmodel.dart';
import 'package:sip_social/ui/screens/main/widgets/custom_appbar.dart';
import 'package:stacked/stacked.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onViewModelReady: (viewModel) {
        viewModel.init();
      },
      fireOnViewModelReadyOnce: true,
      disposeViewModel: false,
      builder: (context, viewModel, child) {
        return Scaffold(
          body: changeIndex(viewModel: viewModel),
        );
      },
      viewModelBuilder: () => MainViewModel(),
    );
  }
}

Widget changeIndex({required MainViewModel viewModel}) {
  switch (viewModel.currentIndex) {
    case 0:
      return const EmailUserNameView();
    case 1:
      return const AllowNotificationView();
    case 2:
      return const AllowLocationView();
    case 3:
      return const NameDOBZipcodeView();
    case 4:
      return const BioView();
    case 5:
      return UploadImageView();
    case 6:
      return const SavingProfileView();
    default:
      return const EmailUserNameView();
  }
}
