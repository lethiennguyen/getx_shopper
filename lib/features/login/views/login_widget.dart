part of 'login_page.dart';

@override
Widget formLogin(LoginController controller) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBoxCustom.h76,
          SvgPicture.asset(IconsAssets.logo, width: 158, height: 37),
          SizedBoxCustom.h61,
          Form(
            key: controller.formKey,
            autovalidateMode: controller.submitted.value
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Obx(
              () => Column(
                children: [
                  _formTextInputTaxCode(controller),
                  _formTextInputUserName(controller),
                  _formTextInputPassWord(controller),
                  SizedBoxCustom.h20,
                  _formButtonSubmit(controller),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _formTextInputTaxCode(LoginController controller) {
  return UtilsWidget.buildInPut(
    TextInputModel(
      label: FieldEnum.tax_code.label,
      hint: FieldEnum.tax_code.hint,
      controller: controller.taxCodeController,
      focusNode: controller.taxCodeFocus,
      keyboardType: FieldEnum.tax_code.keyboardType,
      validator: FieldEnum.tax_code.validate,
      errorText: controller.errorTaxCode.value,
      useDefaultError: false,
      onChanged: (val) {
        controller.validateField(FieldEnum.tax_code, val);
      },
    ),
  );
}

Widget _formTextInputUserName(LoginController controller) {
  return UtilsWidget.buildInPut(
    TextInputModel(
      label: FieldEnum.user_name.label,
      hint: FieldEnum.user_name.hint,
      controller: controller.userNameController,
      focusNode: controller.userNameFocus,
      keyboardType: FieldEnum.user_name.keyboardType,
      validator: FieldEnum.user_name.validate,
      errorText: controller.errorUserName.value,
      useDefaultError: false,
      onChanged: (val) {
        controller.validateField(FieldEnum.user_name, val);
      },
    ),
  );
}

Widget _formTextInputPassWord(LoginController controller) {
  return UtilsWidget.buildInPut(
    TextInputModel(
      label: FieldEnum.password.label,
      hint: FieldEnum.password.hint,
      controller: controller.passwordController,
      focusNode: controller.passwordFocus,
      keyboardType: FieldEnum.password.keyboardType,
      validator: FieldEnum.password.validate,
      isPassword: true,
      errorText: controller.errorPassword.value,
      useDefaultError: false,
      onChanged: (val) {
        controller.validateField(FieldEnum.password, val);
      },
    ),
  );
}

Widget _formButtonSubmit(LoginController controller) {
  return UtilsWidget.buildButton(
    width: 345,
    height: 48,
    text: AppStrings.loginButton,
    isSubmitting: controller.isSubmitting.value,
    isIconText: false,
    onPressed: () {
      controller.isSubmitting.value ? null : controller.login();
    },
  );
}

Widget _formBottomNavigate() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 21),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _bottomNavigator(
          asset: IconsAssets.headphone,
          textButton: AppStrings.helpButton,
        ),
        SizedBoxCustom.w8,
        _bottomNavigator(
          asset: IconsAssets.Social_link,
          textButton: AppStrings.groupButton,
        ),
        SizedBoxCustom.w8,
        _bottomNavigator(
          asset: IconsAssets.search_normal,
          textButton: AppStrings.searchNormalButton,
        ),
      ],
    ),
  ).paddingOnly(bottom: AppDimens.padding30);
}

Widget _bottomNavigator({required String asset, required String textButton}) {
  return Expanded(
    child: UtilsWidget.buildButton(
      height: 54,
      text: textButton,
      color: AppColors.colorWhite,
      isIconText: true,
      asset: asset,
      border: Border.all(color: AppColors.colorGray, width: 1),
      onPressed: () {},
    ),
  );
}
