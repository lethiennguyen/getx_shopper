import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputModel {
  String? label;
  String? hint;
  TextEditingController controller;
  FocusNode? focusNode;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  Icon? icon;
  bool isPassword;
  bool isShowIcon;
  bool isDataEntryRequire;
  final bool useDefaultError;
  String? errorText;
  ValueChanged<String>? onChanged;

  TextInputModel({
    this.label = '',
    this.hint = '',
    required this.controller,
    this.focusNode,
    this.keyboardType,
    this.validator,
    this.icon,
    this.isPassword = false,
    this.isShowIcon = true,
    this.isDataEntryRequire = false,
    this.useDefaultError = true,
    this.errorText = '',
    this.onChanged,
  });
}
