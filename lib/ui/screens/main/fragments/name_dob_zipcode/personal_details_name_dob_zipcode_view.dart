import 'package:flutter/material.dart';
import 'package:sip_social/ui/screens/main/fragments/name_dob_zipcode/fragments/intro_view.dart';
import 'package:sip_social/ui/screens/main/fragments/name_dob_zipcode/fragments/name_dob_zipcode_details_view.dart';
import 'package:sip_social/ui/screens/main/main_viewmodel.dart';
import 'package:sip_social/ui/screens/main/widgets/custom_appbar.dart';
import 'package:stacked/stacked.dart';

class NameDOBZipcodeView extends ViewModelWidget<MainViewModel> {
  const NameDOBZipcodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel viewModel) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          pageIndex: 1,
          hasSkipButton: true,
          onSkip: () => viewModel.setIndex(index: 4),
          previousPageIndex: 0,
        ),
      ),
      body: changeIndex(viewModel: viewModel),
    );
  }
}

Widget changeIndex({required MainViewModel viewModel}) {
  switch (viewModel.currentIndexOfNameDOBZipCodeView) {
    case 0:
      return const NameDOBZipcodeIntroView();
    case 1:
      return const NameDOBZipcodeDetailsView();
    default:
      return const NameDOBZipcodeIntroView();
  }
}
