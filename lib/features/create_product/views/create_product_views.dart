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
              _formTextInputName(controller),
              _formTextInputPrice(controller),
              _formTextInputQuantity(controller),
              _formTextInputCover(controller),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _imageProduct(CreateProductController controller) {
  return Container(
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: AppColors.colorWhite,
      border: Border.all(color: AppColors.colorWhiteGray, width: 1),
    ),
    height: Get.height * 0.2,
    child: Obx(
      () => ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        child: controller.url.value.isEmpty
            ? Image.asset(IconsAssets.noImage, fit: BoxFit.contain)
            : Image.network(controller.url.value, fit: BoxFit.contain),
      ),
    ),
  );
}

Widget _formTextInputName(CreateProductController controller) {
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

Widget _formTextInputPrice(CreateProductController controller) {
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

Widget _formTextInputQuantity(CreateProductController controller) {
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

Widget _buttonBack(CreateProductController controller) {
  return UtilsWidget.buildButton(
    text: AppStrings.create,
    height: 50,
    onPressed: () async {
      await controller.createProduct();
    },
  ).paddingOnly(bottom: AppDimens.padding30);
}

Widget _formTextInputCover(CreateProductController controller) {
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
        width: 70,
        height: 54,
        text: AppStrings.load,
        onPressed: () {
          controller.loadImage();
        },
      ),
    ],
  );
}
