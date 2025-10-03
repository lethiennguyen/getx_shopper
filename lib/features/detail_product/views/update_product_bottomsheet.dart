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
        SizedBoxCustom.h16,
        _formTextInputName(controller),
        _formTextInputPrice(controller),
        _formTextInputQuantity(controller),
        SizedBoxCustom.h32,
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
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => ImagePickerWidget(
            imageUrl: controller.url.value.isNotEmpty
                ? controller.url.value
                : controller.product.value?.cover ?? '',
          ),
        ),
        SizedBoxCustom.w16,
        UtilsWidget.buildButton(
          textColor: AppColors.colorWhite,
          height: 54,
          width: 80,
          text: AppStrings.load,
          onPressed: () {
            controller.upImage();
          },
        ),
      ],
    ),
  );
}

Widget _formTextInputName(DetailAndUpdateProductController controller) {
  return UtilsWidget.buildInPut(
    TextInputModel(
      icon: Icon(Icons.drive_file_rename_outline_sharp, color: colorIcon),
      label: FieldEnum.name.label,
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
      icon: Icon(Icons.monetization_on, color: colorIcon),
      label: FieldEnum.price.label,
      hint: FieldEnum.price.hint,
      controller: controller.priceController,
      focusNode: controller.priceFocus,
      keyboardType: TextInputType.number,
      validator: FieldEnum.price.validate,
      useDefaultError: true,
    ),
  );
}

Widget _formTextInputQuantity(DetailAndUpdateProductController controller) {
  return UtilsWidget.buildInPut(
    TextInputModel(
      icon: Icon(Icons.warehouse, color: colorIcon),
      label: FieldEnum.quantity.label,
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
          'cover': controller.url.value.isNotEmpty
              ? controller.url.value
              : controller.product.value?.cover ?? '',
        },
      );
    },
  );
}

Color colorIcon = AppColors.colorOrange;
