import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/base/base_controller/base_controller.dart';
import 'package:getx_curd/core/router/app_router.dart';
import 'package:getx_curd/core/values/strings.dart';
import 'package:getx_curd/features/login/model/login_request_model.dart';
import 'package:getx_curd/utils/show_popup.dart';
import 'package:hive/hive.dart';

import '../../../core/values/key.dart';
import '../../../shares/enum/enum_field.dart';
import '../repository/login_repository.dart';

class LoginController extends BaseGetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController taxCodeController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode taxCodeFocus = FocusNode();
  final FocusNode userNameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final RxString errorTaxCode = RxString('');
  final RxString errorUserName = RxString('');
  final RxString errorPassword = RxString('');

  final RxBool isPasswordVisible = false.obs;
  final isSubmitting = false.obs;
  final submitted = false.obs;

  late final AuthRepository _authRepository = AuthRepository(this);
  late final LoginRequestModel _loginRequestModel = LoginRequestModel();

  @override
  void onInit() {
    super.onInit();
    _restoreFromHive();
  }

  void validateField(FieldEnum field, String value) {
    switch (field) {
      case FieldEnum.tax_code:
        errorTaxCode.value =
            FieldEnum.tax_code.validate(taxCodeController.text) ?? '';
        break;
      case FieldEnum.user_name:
        errorUserName.value =
            FieldEnum.user_name.validate(userNameController.text) ?? '';
        break;
      case FieldEnum.password:
        errorPassword.value =
            FieldEnum.password.validate(passwordController.text) ?? '';
        break;
      default:
        break;
    }
  }

  /// Validate tất cả các field
  bool _validateAllFields() {
    bool hasError = false;
    for (var field in FieldEnum.values) {
      validateField(field, '');
      switch (field) {
        case FieldEnum.tax_code:
          if (errorTaxCode.value.isNotEmpty) hasError = true;
          break;
        case FieldEnum.user_name:
          if (errorUserName.value.isNotEmpty) hasError = true;
          break;
        case FieldEnum.password:
          if (errorPassword.value.isNotEmpty) hasError = true;
          break;
        default:
          break;
      }
    }
    return !hasError;
  }

  Future<void> login() async {
    submitted.value = true;
    isSubmitting.value = true;
    if (!_validateAllFields()) {
      isSubmitting.value = false;
      return;
    }
    try {
      final taxCode = taxCodeController;
      final usersName = userNameController;
      final passWord = passwordController;
      _loginRequestModel
        ..tax_code = int.parse(taxCode.text)
        ..user_name = usersName.text
        ..password = passWord.text;
      final result = await _authRepository.postUserProviders(
        _loginRequestModel,
      );
      if (result == null) {
        isSubmitting.value = false;
        ShowPopup.showDiaLogNotifyton(
          AppStrings.title,
          AppStrings.messageErrorRequest,
          AppStrings.okButton,
          null,
        );
        return;
      }
      if (result.success) {
        final box = Hive.box(HiveBoxNames.auth);

        box.put(HiveKeys.isLoggedIn, true);
        box.put(HiveKeys.tax_code, taxCode.text);
        box.put(HiveKeys.user_name, usersName.text);
        box.put(HiveKeys.password, passWord.text);
        box.put(HiveKeys.token, result.data?.token);

        Get.offAllNamed(AppRouter.routerHome);
      } else {
        ShowPopup.showDiaLogNotifyton(
          AppStrings.title,
          AppStrings.messageLogin,
          AppStrings.okButton,
          null,
        );
      }
    } finally {
      isSubmitting.value = false;
    }
  }

  void _restoreFromHive() {
    final taxCode = taxCodeController;
    final usesName = userNameController;
    final password = passwordController;
    final box = Hive.box(HiveBoxNames.auth);
    taxCode.text = box.get(HiveKeys.tax_code, defaultValue: '').toString();
    usesName.text = box.get(HiveKeys.user_name, defaultValue: '');
    password.text = box.get(HiveKeys.password, defaultValue: '');
  }
}
