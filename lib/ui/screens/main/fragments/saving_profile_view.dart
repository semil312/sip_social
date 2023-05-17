import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/widgets/textfield_label.dart';

class SavingProfileView extends StatelessWidget {
  const SavingProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: $styles.colors.backgroundColor,
      body: Center(
        child: Stack(
          children: [
            Center(child: SvgPicture.asset('assets/images/saving_profile_bg.svg')),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextFieldLabel(title: "HOLD ON"),
                  Gap($styles.insets.l),
                  Text(
                    "We are saving \nyour profile...",
                    textAlign: TextAlign.start,
                    style: $styles.text.displayMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
