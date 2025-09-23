part of 'detail_product_page.dart';

class ShowUpdate {
  static Widget showSheet(DetailAndUpdateProductController controller) {
    return BottomSheet(
      enableDrag: false,
      showDragHandle: false,
      onClosing: () {},
      builder: (context) {
        return Container(
          height: Get.height * 0.8,
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: SingleChildScrollView(child: _body(controller)),
        );
      },
    );
  }

  static Widget _body(DetailAndUpdateProductController controller) {
    return Column(
      children: [
        _headerDropDown(),
        _imageProduct(controller),
        _formTextInputName(controller),
        _formTextInputPrice(controller),
        _formTextInputQuantity(controller),
        _formTextInputCover(controller),
        _buttonBack(controller),
      ],
    );
  }
}

Widget _headerDropDown() {
  return Container(
    alignment: Alignment.topCenter,
    width: AppDimens.sizeDialogNotiIcon,
    height: AppDimens.padding4,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppDimens.btnSmall),
      color: AppColors.colorOrange,
    ),
  ).paddingSymmetric(vertical: AppDimens.paddingVerySmall);
}

Widget _imageProduct(DetailAndUpdateProductController controller) {
  return Container(
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: AppColors.colorWhite,
      border: Border.all(color: AppColors.colorWhiteGray, width: 1),
    ),
    height: Get.height * 0.2,
    child: ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      child: Obx(
        () => Image.network(
          controller.url.value.isNotEmpty
              ? controller.url.value
              : controller.product.value?.cover ?? '',
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}

Widget _formTextInputName(DetailAndUpdateProductController controller) {
  return UtilsWidget.buildInPut(
    TextInputModel(
      icon: Icon(
        Icons.drive_file_rename_outline_sharp,
        color: AppColors.colorOrange,
      ),
      label: FieldEnum.name.lable,
      hint: FieldEnum.name.hint,
      controller: controller.nameController,
      focusNode: controller.nameFocus,
      keyboardType: FieldEnum.name.keyboardType,
      validator: FieldEnum.name.validate,
      useDefaultError: true,
    ),
  );
}

Widget _formTextInputPrice(DetailAndUpdateProductController controller) {
  return UtilsWidget.buildInPut(
    TextInputModel(
      icon: Icon(Icons.monetization_on, color: AppColors.colorOrange),
      label: FieldEnum.price.lable,
      hint: FieldEnum.price.hint,
      controller: controller.priceController,
      focusNode: controller.priceFocus,
      keyboardType: FieldEnum.price.keyboardType,
      validator: FieldEnum.price.validate,
      useDefaultError: true,
    ),
  );
}

Widget _formTextInputQuantity(DetailAndUpdateProductController controller) {
  return UtilsWidget.buildInPut(
    TextInputModel(
      icon: Icon(Icons.warehouse, color: AppColors.colorOrange),
      label: FieldEnum.quantity.lable,
      hint: FieldEnum.quantity.hint,
      controller: controller.quantityController,
      focusNode: controller.quantityFocus,
      keyboardType: FieldEnum.quantity.keyboardType,
      validator: FieldEnum.quantity.validate,
      useDefaultError: true,
    ),
  );
}

Widget _buttonBack(DetailAndUpdateProductController controller) {
  return UtilsWidget.buildButton(
    text: AppStrings.update,
    height: 50,
    onPressed: () {
      Get.back(
        result: {
          'name': controller.nameController.text,
          'price': controller.priceController.text,
          'quantity': controller.quantityController.text,
          'cover': controller.coverController.text ?? '',
        },
      );
    },
  );
}

Widget _formTextInputCover(DetailAndUpdateProductController controller) {
  return Row(
    children: [
      Expanded(
        child: UtilsWidget.buildInPut(
          TextInputModel(
            label: FieldEnum.cover.lable,
            hint: FieldEnum.cover.hint,
            icon: Icon(Icons.image, color: AppColors.colorOrange),
            controller: controller.coverController,
            focusNode: controller.coverFocus,
            keyboardType: FieldEnum.cover.keyboardType,
            validator: FieldEnum.cover.validate,
            useDefaultError: true,
          ),
        ),
      ),
      SizedBoxCustom.w16,
      UtilsWidget.buildButton(
        text: AppStrings.load,
        onPressed: () {
          controller.loadImage();
        },
      ),
    ],
  );
}
