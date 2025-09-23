import 'package:flutter/cupertino.dart';

enum FieldEnum { name, price, quantity, cover, tax_code, user_name, password }

extension ProductFieldExtentsion on FieldEnum {
  String? validate(String? value) {
    switch (this) {
      case FieldEnum.cover:
        if (value == null || value.isEmpty) {
          return "Ảnh sản phẩm không được để trống";
        }
        return null;
      case FieldEnum.price:
        value = (value ?? '').trim();
        if (value.isEmpty) return "Giá không được để trống";
        if (int.tryParse(value) == null || int.parse(value) <= 0) {
          return "Giá phải là số dương";
        }
        return null;
      case FieldEnum.quantity:
        if (value == null || value.isEmpty) {
          return "Số lượng không được để trống";
        }
        if (int.tryParse(value) == null || int.parse(value) <= 0) {
          return "Số lượng phải là số dương";
        }
        return null;
      case FieldEnum.name:
        value = (value ?? '').trim();
        if (value.isEmpty) {
          return "Tên sản phẩm không được để trống";
        }
      case FieldEnum.tax_code:
        value = (value ?? '').trim();
        if (value.length != 10) return "Mã số thuế phải đúng 10 ký tự";
        return null;
      case FieldEnum.user_name:
        if ((value ?? '').trim().isEmpty) {
          return "Tài khoản không được để trống";
        }
        return null;
      case FieldEnum.password:
        value = (value ?? '').trim();
        if (value.length < 6 || value.length > 50) {
          return "Mật khẩu từ 6 đến 50 ký tự";
        }
        return null;
    }
    return null;
  }

  String get lable {
    switch (this) {
      case FieldEnum.cover:
        return "Ảnh sản phẩm";
      case FieldEnum.name:
        return "Tên sản phẩm";
      case FieldEnum.price:
        return "Giá";
      case FieldEnum.quantity:
        return "Số lượng tồn kho";
      case FieldEnum.tax_code:
        return "Mã số thuế";
      case FieldEnum.user_name:
        return "Tài khoản";
      case FieldEnum.password:
        return "Mật khẩu";
    }
  }

  String get hint {
    switch (this) {
      case FieldEnum.name:
        return "Tên sản phẩm";
      case FieldEnum.price:
        return "Giá";
      case FieldEnum.quantity:
        return "Số lượng tồn kho";
      case FieldEnum.cover:
        return "Chọn ảnh sản phẩm";
      case FieldEnum.tax_code:
        return "000012";
      case FieldEnum.user_name:
        return "Tài khoản";
      case FieldEnum.password:
        return "Mật khẩu";
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
