import 'package:flutter/cupertino.dart';
import 'package:getx_curd/core/values/strings.dart';

enum FieldEnum { name, price, quantity, cover, tax_code, user_name, password }

extension ProductFieldExtentsion on FieldEnum {
  String? get hint {
    switch (this) {
      case FieldEnum.name:
        return AppStrings.name;
      case FieldEnum.price:
        return AppStrings.price;
      case FieldEnum.quantity:
        return AppStrings.quantity;
      case FieldEnum.cover:
        return null;
      case FieldEnum.tax_code:
        return AppStrings.taxCode;
      case FieldEnum.user_name:
        return AppStrings.userName;
      case FieldEnum.password:
        return AppStrings.password;
    }
  }

  String? validate(String? value) {
    switch (this) {
      case FieldEnum.cover:
        return null;
      case FieldEnum.price:
        value = (value ?? '').trim();
        if (value.isEmpty) return AppStrings.priceValidate;
        if (int.tryParse(value) == null || int.parse(value) <= 0) {
          return AppStrings.price_validate_positive_number;
        }
        return null;
      case FieldEnum.quantity:
        if (value == null || value.isEmpty) {
          return AppStrings.quantityValidate;
        }
        if (int.tryParse(value) == null || int.parse(value) <= 0) {
          return AppStrings.quantity_validate_positive_number;
        }
        return null;
      case FieldEnum.name:
        value = (value ?? '').trim();
        if (value.isEmpty) {
          return AppStrings.nameValidate;
        }
      case FieldEnum.tax_code:
        value = (value ?? '').trim();
        if (value.length != 10) return AppStrings.taxCodeValidate;
        return null;
      case FieldEnum.user_name:
        if ((value ?? '').trim().isEmpty) {
          return AppStrings.userNameValidate;
        }
        return null;
      case FieldEnum.password:
        value = (value ?? '').trim();
        if (value.length < 6 || value.length > 50) {
          return AppStrings.passwordValidate;
        }
        return null;
    }
    return null;
  }

  String? get label {
    switch (this) {
      case FieldEnum.cover:
        return AppStrings.coverLabel;
      case FieldEnum.name:
        return AppStrings.nameLabel;
      case FieldEnum.price:
        return AppStrings.priceLabel;
      case FieldEnum.quantity:
        return AppStrings.quantityLabel;
      case FieldEnum.tax_code:
        return AppStrings.taxCodeLabel;
      case FieldEnum.user_name:
        return AppStrings.userNameLabel;
      case FieldEnum.password:
        return AppStrings.passwordLabel;
    }
  }

  TextInputType get keyboardType {
    switch (this) {
      case FieldEnum.price:
      case FieldEnum.quantity:
      case FieldEnum.tax_code:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }
}
