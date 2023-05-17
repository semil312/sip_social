// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {Key? key, this.size = 22, this.color})
      : super(key: key);
  final AppIcons icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    String i = describeEnum(icon).toLowerCase();
    String path = 'assets/icons/icon-$i.svg';

    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: SvgPicture.asset(path, width: size, height: size, color: color),
      ),
    );
  }
}

enum AppIcons {
  hiw_profile_single,
  hiw_find_your_sipper,
  hiw_join_club,
  hiw_sip_radar,
  arrow_right,
  arrow_left_cupertino,
  search,
  hiw_plus,
  hiw_minus,
  profile_setting,
  profile_follower,
  profile_edit_image,
  profile_following,
  upload_image_edit,
  profile_block,
  profile_chat,
}
