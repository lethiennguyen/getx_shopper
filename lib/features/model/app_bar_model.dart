import 'package:flutter/cupertino.dart';

class AppBarModel {
  String? title;
  String? imageSVG;
  Widget? buttonICon;
  bool isBack;

  AppBarModel({
    this.isBack = false,
    this.title,
    this.imageSVG,
    this.buttonICon,
  });
}
