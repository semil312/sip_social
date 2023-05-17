import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/screens/authentication/auth_view_model.dart';
import 'package:sip_social/ui/screens/authentication/fragments/login_view.dart';
import 'package:sip_social/ui/widgets/custom_button.dart';
import 'package:stacked/stacked.dart';

class OtpView extends ViewModelWidget<AuthViewModel> {
  const OtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return Scaffold(
      backgroundColor: $styles.colors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: $styles.insets.s),
          child: Column(
            children: [
              otpHeaderWidget(viewModel: viewModel),
              Gap($styles.insets.xl),
              pinputWidget(viewModel: viewModel),
              const Spacer(),
              optFooterWidget(viewModel: viewModel),
            ],
          ),
        ),
      ),
    );
  }
}

Widget otpHeaderWidget({required AuthViewModel viewModel}) {
  return Column(
    children: [
      headerWidget(),
      Text(
        "Thanks, now we just need to verify \nyour number. We have sent a code to",
        textAlign: TextAlign.center,
        style: $styles.text.titleMedium.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
      Text(
        viewModel.phoneNumber ?? "",
        textAlign: TextAlign.center,
        style: $styles.text.titleMedium.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    ],
  );
}

Widget pinputWidget({required AuthViewModel viewModel}) {
  return Form(
    key: viewModel.otpFormKey,
    child: Column(
      children: [
        Pinput(
          length: 6,
          defaultPinTheme: PinTheme(
            width: 50,
            height: 50,
            textStyle: $styles.text.bodyLarge.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: $styles.colors.black,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: $styles.colors.black),
            ),
          ),
          errorPinTheme: PinTheme(
            width: 50,
            height: 50,
            textStyle: $styles.text.bodyLarge.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: $styles.colors.error,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: $styles.colors.error),
            ),
          ),
          validator: (value) => viewModel.validateOTP(value),
        ),
        Gap($styles.insets.s),
        Row(
          children: [
            Gap($styles.insets.xs),
            Text(
              "Clear Code",
              style: $styles.text.titleMedium.copyWith(
                fontWeight: FontWeight.w400,
                height: 0,
                fontSize: 14,
                letterSpacing: 0,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        Gap($styles.insets.s),
        Text(
          "Resend",
          textAlign: TextAlign.center,
          style: $styles.text.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

Widget optFooterWidget({required AuthViewModel viewModel}) {
  return Column(
    children: [
      CustomButton(
        title: 'Confirm',
        onTap: () {
          viewModel.navigateToHowItWorks();
        },
        isDisable: viewModel.phoneController.text.isEmpty,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.m),
        child: Text(
          "Terms & Conditions",
          textAlign: TextAlign.center,
          style: $styles.text.bodyMedium.copyWith(
            color: $styles.colors.black,
            fontSize: 12,
            height: 1.5,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      Gap($styles.insets.s),
    ],
  );
}
