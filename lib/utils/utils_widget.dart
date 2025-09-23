import 'dart:io';

import 'package:cloudinary_url_gen/transformation/resize/fit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/values/colors.dart';
import 'package:getx_curd/features/model/shopping_cart_operation_model.dart';
import 'package:getx_curd/features/model/text_input_model.dart';
import 'package:getx_curd/utils/utils_text.dart';
import 'package:getx_curd/utils/widgets/size_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../core/values/assets.dart';
import '../core/values/dimens.dart';

class UtilsWidget {
  static const String appName = "My Flutter App";
  static DateTime? _dateTime;
  static int? _oldFunc;

  /// Sử dụng để tránh trường hợp click liên tiếp khi thực hiện function
  static Widget baseOnAction({required Function onTap, required Widget child}) {
    return InkWell(
      onTap: () {
        DateTime now = DateTime.now();
        if (_dateTime == null ||
            now.difference(_dateTime ?? DateTime.now()) > 1.seconds ||
            onTap.hashCode != _oldFunc) {
          _dateTime = now;
          _oldFunc = onTap.hashCode;
          onTap();
        }
      },
      child: child,
    );
  }

  static Widget buildInPut(TextInputModel textInputModel) {
    RxBool isObscure = textInputModel.isPassword.obs;
    RxString inputText = ''.obs;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextUtils(
            text: textInputModel.label ?? '',
            color: AppColors.colorGray3,
            fontWeight: FontWeight.w700,
            size: AppDimens.sizeTextMediumTb,
          ),
          TextFormField(
            controller: textInputModel.controller,
            focusNode: textInputModel.focusNode,
            keyboardType: textInputModel.keyboardType,
            validator: textInputModel.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: isObscure.value.obs.value,
            onChanged: (val) {
              inputText.value = val;
              textInputModel.onChanged?.call(val);
            },
            cursorColor: AppColors.colorOrange,
            decoration: InputDecoration(
              hintText: textInputModel.hint,
              contentPadding: const EdgeInsets.all(16),
              errorStyle: textInputModel.useDefaultError
                  ? null
                  : const TextStyle(height: 0, fontSize: 0),
              prefixIcon: textInputModel.icon,
              suffixIcon: !textInputModel.isShowIcon
                  ? null
                  : (textInputModel.isPassword
                        ? GestureDetector(
                            onTap: () {
                              isObscure.value = !isObscure.value;
                              print("isObscure: ${isObscure}");
                              print("pass: ${textInputModel.isPassword}");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                isObscure.value
                                    ? IconsAssets.eye
                                    : IconsAssets.eye_slash,
                                width: 12,
                                height: 12,
                              ),
                            ),
                          )
                        : (inputText.value.isNotEmpty)
                        ? GestureDetector(
                            onTap: () {
                              textInputModel.controller.clear();
                              inputText.value = '';
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                IconsAssets.clear,
                                width: 10,
                                height: 10,
                              ),
                            ),
                          )
                        : null),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.colorOrange),
                borderRadius: BorderRadius.circular(6),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.colorGray1),
                borderRadius: BorderRadius.circular(6),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.colorOrange),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 16),
            height: 16,
            alignment: Alignment.centerRight,
            child: TextUtils(
              text: textInputModel.errorText ?? '',
              color: AppColors.colorOrange2,
              fontWeight: FontWeight.w400,
              size: AppDimens.sizeTextSmaller,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  static Widget buildButton({
    double? width,
    double? height,
    required String text,
    bool? isSubmitting = false,
    bool? isIconText = false,
    BorderRadius? borderRadius,
    Border? border,
    String? asset,
    required VoidCallback? onPressed,
    Color? textColor,
    Color? color,
  }) {
    return InkWell(
      onTap: isSubmitting == true ? null : onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? AppColors.colorOrange,
          borderRadius: borderRadius ?? BorderRadius.circular(6),
          border:
              border ?? Border.all(width: 1, color: AppColors.colorWhiteGray),
        ),
        child: isIconText == false
            ? isSubmitting == true
                  ? Lottie.asset(Lotteri.loading, width: 50, height: 50)
                  : Center(
                      child: Text(
                        text,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor ?? Colors.white,
                        ),
                      ),
                    )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (asset != null)
                    SvgPicture.asset(asset, width: 20, height: 20),
                  if (asset != null && asset.isNotEmpty)
                    const SizedBox(width: 8),
                  SizedBoxCustom.h8,
                  TextUtils(
                    text: text,
                    color: textColor ?? Colors.black,
                    fontWeight: FontWeight.w600,
                    size: 12,
                  ),
                ],
              ),
      ),
    );
  }

  /// Widget cài đặt việc refresh page
  static Widget buildSmartRefresher({
    required RefreshController refreshController,
    required Widget child,
    ScrollController? scrollController,
    Function()? onRefresh,
    Function()? onLoadMore,
    bool enablePullUp = false,
    bool enablePullDown = false,
  }) {
    return SmartRefresher(
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      scrollController: scrollController,
      header: const MaterialClassicHeader(),
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      footer: buildSmartRefresherCustomFooter(),
      child: child,
    );
  }

  static Widget buildSmartRefresherCustomFooter() {
    return CustomFooter(
      builder: (context, mode) {
        if (mode == LoadStatus.loading) {
          return const CupertinoActivityIndicator();
        } else {
          return const Opacity(
            opacity: 0.0,
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  static Widget buildIconShoppingCart({
    required VoidCallback onPressed,
    required String numberItem,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          IconButton(
            onPressed: onPressed,
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                IconsAssets.shopping_cart,
                color: AppColors.colorBlack,
                width: 24,
                height: 24,
              ),
            ),
          ),
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.colorOrange,
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints(minWidth: 16, minHeight: 16),
              child: TextUtils(
                text: numberItem,
                size: AppDimens.sizeTextSmaller,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showSnackBar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.colorWhite,
      borderRadius: 8,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      borderColor: AppColors.colorGray,
      borderWidth: 1,
      icon: Icon(Icons.emoji_emotions, color: AppColors.colorOrange),
      titleText: TextUtils(
        text: title,
        fontWeight: FontWeight.bold,
        size: AppDimens.sizeTextMediumTb,
        color: AppColors.colorOrange,
      ),
      messageText: TextUtils(
        text: message,
        fontWeight: FontWeight.normal,
        size: AppDimens.sizeTextSmall,
        color: AppColors.colorBlack,
      ),
    );
  }

  static Widget formDetailProduct(
    ShoppingCartOperationModel shoppingCartModel,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              shoppingCartModel.cover,
              width: 80,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 16, 0, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUtils(
                  text: shoppingCartModel.name,
                  size: AppDimens.sizeTextSmall,
                  color: AppColors.colorGray,
                  fontWeight: FontWeight.w600,
                ),
                SizedBoxCustom.h8,
                Row(
                  children: [
                    TextUtils(
                      text: shoppingCartModel.price,
                      size: AppDimens.sizeTextSmall,
                      color: AppColors.colorOrange,
                      fontWeight: FontWeight.w600,
                    ),
                    Container(
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.colorGray.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buttonIcon(shoppingCartModel.onReduce),
                          Container(
                            width: 25,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: AppColors.colorGray,
                                  width: 1,
                                ),
                                right: BorderSide(
                                  color: AppColors.colorGray,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Center(
                              child: TextUtils(
                                text: shoppingCartModel.quantity,
                                size: AppDimens.sizeTextMediumTb,
                                fontWeight: FontWeight.w700,
                                color: AppColors.colorGray,
                              ),
                            ),
                          ),
                          _buttonIcon(shoppingCartModel.onIncrease),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buttonIcon(VoidCallback? onClick) {
    return GestureDetector(
      onTap: () {
        onClick;
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          color: Colors.transparent,
        ),
        child: Icon(Icons.add, size: 18, color: AppColors.colorGray),
      ),
    );
  }
}
