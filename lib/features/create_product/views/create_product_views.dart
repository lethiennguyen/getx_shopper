part of 'create_product_page.dart';

Widget _buildBody(CreateProductController controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Obx(
      () => SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          autovalidateMode: controller.autoValidateMode.value,
          child: Column(
            children: [
              _imageProduct(controller),
              SizedBoxCustom.h8,
              _formTextInputName(controller),
              SizedBoxCustom.h8,
              _formTextInputPrice(controller),
              SizedBoxCustom.h8,
              _formTextInputQuantity(controller),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _imageProduct(CreateProductController controller) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextUtils(
              text: FieldEnum.cover.label ?? '',
              size: AppDimens.sizeTextMedium,
              availableStyle: StyleEnum.MbTitle1Bold,
            ),
            TextUtils(
              text: ' *',
              color: AppColors.colorRed,
              availableStyle: StyleEnum.MbTitle1Bold,
            ),
          ],
        ),
        SizedBoxCustom.h8,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => controller.url.value.isNotEmpty
                  ? ImagePickerWidget(imageUrl: controller.url.value)
                  : Image.asset(
                      IconsAssets.noImage,
                      fit: BoxFit.contain,
                      height: 150,
                      width: 150,
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
      ],
    ),
  );
}

Widget _formTextInputName(CreateProductController controller) {
  return UtilsWidget.buildInPut(
    TextInputModel(
      icon: Icon(Icons.drive_file_rename_outline_sharp, color: colorIcon()),
      label: FieldEnum.name.label,
      hint: FieldEnum.name.hint,
      controller: controller.nameController,
      focusNode: controller.nameFocus,
      keyboardType: FieldEnum.name.keyboardType,
      validator: FieldEnum.name.validate,
      useDefaultError: true,
      isDataEntryRequire: true,
    ),
  );
}

Widget _formTextInputPrice(CreateProductController controller) {
  return UtilsWidget.buildInPut(
    TextInputModel(
      icon: Icon(Icons.monetization_on, color: colorIcon()),
      label: FieldEnum.price.label,
      hint: FieldEnum.price.hint,
      controller: controller.priceController,
      focusNode: controller.priceFocus,
      keyboardType: FieldEnum.price.keyboardType,
      validator: FieldEnum.price.validate,
      useDefaultError: true,
      isDataEntryRequire: true,
    ),
  );
}

Widget _formTextInputQuantity(CreateProductController controller) {
  return UtilsWidget.buildInPut(
    TextInputModel(
      icon: Icon(Icons.warehouse, color: colorIcon()),
      label: FieldEnum.quantity.label,
      hint: FieldEnum.quantity.hint,
      controller: controller.quantityController,
      focusNode: controller.quantityFocus,
      keyboardType: FieldEnum.quantity.keyboardType,
      validator: FieldEnum.quantity.validate,
      useDefaultError: true,
      isDataEntryRequire: true,
    ),
  );
}

Widget _buttonBack(CreateProductController controller) {
  return UtilsWidget.buildButton(
    text: AppStrings.create,
    height: 50,
    onPressed: () async {
      await controller.createProduct();
    },
  ).paddingOnly(bottom: AppDimens.padding30);
}

Color colorIcon() {
  return AppColors.colorOrange;
}
