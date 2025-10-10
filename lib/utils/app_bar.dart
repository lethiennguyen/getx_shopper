
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/values/colors.dart';

class BuildAppBar {
  static PreferredSizeWidget build({
    Widget? title,
    List<Widget>? actions,
    Widget? leading,
    bool backButton = true,
    AlignmentGeometry alignment = Alignment.center,
    double? width,
    Function()? onPressed,
    Color? backgroundColor,
    Color? backButtonColor,
    PreferredSizeWidget? bottom,
  }) {
    Widget? leadingAppBar;
    if (backButton) {
      leadingAppBar =
          leading ??
          BackButton(
            color: backButtonColor ?? AppColors.colorOrange,
            onPressed: onPressed,
          );
    }
    return AppBar(
      leading: leadingAppBar,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      surfaceTintColor: AppColors.colorOrange,
      bottom: bottom,
      title: width == null
          ? title
          : Align(
              alignment: alignment,
              child: SizedBox(width: width, child: title),
            ),
      automaticallyImplyLeading: backButton,
      backgroundColor: backgroundColor ?? AppColors.colorWhite,
      centerTitle: true,
      actions: actions,
    );
  }
}
