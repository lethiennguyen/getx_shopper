import 'dart:io';

import 'package:cloudinary_url_gen/transformation/resize/fit.dart';
import 'package:flutter/material.dart';
import 'package:getx_curd/core/values/assets.dart';
import 'package:getx_curd/core/values/colors.dart';
import 'package:getx_curd/core/values/dimens.dart';
import 'package:getx_curd/core/values/strings.dart';
import 'package:getx_curd/utils/utils_widget.dart';
import 'package:getx_curd/utils/widgets/size_box.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? selectedImage;
  final String? imageUrl;
  final bool isLoading;
  final double? width;
  final double? height;
  const ImagePickerWidget({
    super.key,
    this.selectedImage,
    required this.imageUrl,
    this.isLoading = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 150,
      height: height ?? 150,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: Image.network(
        imageUrl ?? IconsAssets.noImage,
        height: 150,
        fit: BoxFit.contain,
      ),
    );
  }
}
