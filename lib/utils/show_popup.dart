import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/values/colors.dart';
import 'package:getx_curd/core/values/dimens.dart';
import 'package:getx_curd/core/values/strings.dart';
import 'package:getx_curd/utils/utils_text.dart';
import 'package:getx_curd/utils/utils_widget.dart';
import 'package:getx_curd/utils/widgets/size_box.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowPopup {
  static int _numDialog = 0;

  static void dismissDialog() {
    if (_numDialog > 0) {
      Get.back();
    }
  }

  static void _showDialog(
    Widget dialog,
    bool isActiveBack, {
    bool barrierDismissible = false,
  }) {
    _numDialog++;
    Get.dialog(
      NavigatorPopHandler(
        onPop: () => onBackPress(isActiveBack),
        child: dialog,
      ),
      barrierDismissible: barrierDismissible,
    ).whenComplete(() => _numDialog--);
  }

  static Future<bool> onBackPress(bool isActiveBack) {
    return Future.value(isActiveBack);
  }

  static Widget _baseButton(
    Function? func,
    String text, {
    double? witdh,
    double? height,
    Color? color,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return UtilsWidget.baseOnAction(
      onTap: () {
        dismissDialog();
        func?.call();
      },
      child: Container(
        width: witdh ?? 150,
        height: height ?? 40,
        decoration: BoxDecoration(
          color: color ?? const Color(0xffF24E1E),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.roboto(
              color: textColor ?? const Color(0xffffffff),
              fontSize: fontSize ?? 14,
              fontWeight: fontWeight ?? FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  static void showDiaLogNotifyton(
    String title,
    String message,
    String buttonText,
    VoidCallback? onComfirm, {
    bool isActiveBack = true,
  }) {
    _showDialog(
      Dialog(
        backgroundColor: AppColors.colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextUtils(
                text: title,
                color: AppColors.colorOrange,
                fontWeight: FontWeight.w700,
                size: AppDimens.sizeTextMediumTb,
              ),
              SizedBoxCustom.h20,
              TextUtils(
                text: message,
                color: AppColors.colorBlack,
                fontWeight: FontWeight.w600,
                size: AppDimens.sizeTextSmaller,
              ),
              SizedBoxCustom.h20,
              _baseButton(
                onComfirm ??
                    () {
                      Get.back();
                    },
                buttonText,
                color: const Color(0xffF24E1E),
                textColor: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
      isActiveBack,
    );
  }

  static void showDiaLogConfirm(
    String title,
    String message,
    VoidCallback? onCancel,
    VoidCallback? onConfirm, {
    bool isActiveBack = true,
  }) {
    _showDialog(
      Dialog(
        backgroundColor: AppColors.colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextUtils(
                text: title,
                color: AppColors.colorOrange,
                fontWeight: FontWeight.w700,
                size: AppDimens.sizeTextMediumTb,
              ),
              SizedBoxCustom.h20,
              TextUtils(
                text: message,
                color: AppColors.colorBlack,
                fontWeight: FontWeight.w600,
                size: AppDimens.sizeTextSmaller,
              ),
              SizedBoxCustom.h32,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _baseButton(
                    onCancel,
                    AppStrings.noButton,
                    color: const Color(0xffF24E1E),
                    textColor: Colors.white,
                    witdh: 100,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBoxCustom.h20,
                  _baseButton(
                    onConfirm,
                    AppStrings.yesButton,
                    color: const Color(0xffF24E1E),
                    textColor: Colors.white,
                    witdh: 100,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      isActiveBack,
    );
  }
}
