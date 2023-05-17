import 'package:flutter/material.dart';
import 'package:sip_social/ui/screens/authentication/auth_view_model.dart';
import 'package:sip_social/ui/screens/authentication/fragments/login_view.dart';
import 'package:sip_social/ui/screens/authentication/fragments/otp_view.dart';
import 'package:stacked/stacked.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      disposeViewModel: false,
      onViewModelReady: (viewModel) {
        viewModel.init();
      },
      fireOnViewModelReadyOnce: true,
      builder: (context, viewModel, child) {
        return Scaffold(
          body: changeIndex(viewModel: viewModel),
        );
      },
      viewModelBuilder: () => AuthViewModel(),
    );
  }
}

Widget changeIndex({required AuthViewModel viewModel}) {
  switch (viewModel.currentIndex) {
    case 0:
      return const LoginView();
    case 1:
      return const OtpView();
    default:
      return const LoginView();
  }
}
