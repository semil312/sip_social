// ignore_for_file: depend_on_referenced_packages
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/screens/authentication/auth_view_model.dart';
import 'package:sip_social/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sip_social/ui/widgets/custom_textfield.dart';
import 'package:sip_social/ui/widgets/textfield_label.dart';
import 'package:stacked/stacked.dart';

class LoginView extends ViewModelWidget<AuthViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return Scaffold(
      backgroundColor: $styles.colors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: $styles.insets.s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              headerWidget(),
              Gap($styles.insets.xl),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextFieldLabel(title: "MOBILE NUMBER"),
                  Gap($styles.insets.xs),
                  mobileNumberWithTitleWidget(viewModel: viewModel)
                ],
              ),
              const Spacer(),
              footerWidget(viewModel: viewModel),
            ],
          ),
        ),
      ),
    );
  }
}

Widget headerWidget() {
  return Column(
    children: [
      SizedBox(
        width: 380,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: $styles.insets.m),
              child: SvgPicture.asset('assets/images/login_vector.svg'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome back",
                        style: $styles.text.displayMedium.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "to",
                            style: $styles.text.displayMedium.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Gap($styles.insets.xxs),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: $styles.colors.secondaryVioletColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: $styles.insets.xs, vertical: $styles.insets.xxs),
                              child: Text(
                                "sip",
                                style: $styles.text.titleSmall.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 40,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                          Gap($styles.insets.xxs),
                          Text(
                            "social",
                            style: $styles.text.titleSmall.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 40,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Text(
        "Enter your mobile number to login",
        textAlign: TextAlign.start,
        style: $styles.text.titleMedium.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    ],
  );
}

Widget mobileNumberWithTitleWidget({required AuthViewModel viewModel}) {
  return Form(
    key: viewModel.phoneFormKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: viewModel.phoneController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            viewModel.notifyListeners();
          },
          validator: (value) => viewModel.validatePhoneNumber(value),
          prefix: Text(
            viewModel.countryCode ?? "",
            style: $styles.text.titleMedium.copyWith(
              height: 0,
              fontSize: 16,
              color: $styles.colors.black,
            ),
          ),
        ),
        Gap($styles.insets.xs),
        Text(
          "Changed number? Contact Us",
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
  );
}

Widget footerWidget({required AuthViewModel viewModel}) {
  return Column(
    children: [
      CustomButton(
        title: 'Login',
        onTap: () {
          if (viewModel.phoneFormKey.currentState!.validate()) {
            final phoneNumber = viewModel.phoneController.text;
            viewModel.loginUser(phoneNumber: phoneNumber);
          }
        },
        isDisable: viewModel.phoneController.text.isEmpty || viewModel.phoneController.text.length < 6,
      ),
      Gap($styles.insets.xs),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.m),
        child: Text(
          "By continuing you will receive an SMS for \nverification. Message and data rates may apply.",
          textAlign: TextAlign.center,
          style: $styles.text.bodyMedium.copyWith(color: $styles.colors.black, fontSize: 12, height: 1.5),
        ),
      ),
      Gap($styles.insets.s),
    ],
  );
}
