import 'package:flutter/material.dart';
import 'package:sip_social/main.dart';

class TextFieldLabel extends StatelessWidget {
  final String title;

  const TextFieldLabel({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: $styles.text.titleSmall.copyWith(
        fontWeight: FontWeight.w900,
        fontSize: 13,
      ),
    );
  }
}
