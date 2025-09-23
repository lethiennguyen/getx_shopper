part of 'detail_product_page.dart';

PreferredSizeWidget _appBar() {
  return AppBar(
    backgroundColor: AppColors.colorWhite,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(Icons.arrow_back),
    ),
    actions: [
      UtilsWidget.buildIconShoppingCart(
        onPressed: () {
          HapticFeedback.lightImpact();
          // controller.onTapShoppingCart();
        },
        numberItem: '12',
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1),
      child: Container(color: AppColors.colorWhiteGray, height: 1),
    ),
  );
}

Widget _bodyFormProduct(DetailAndUpdateProductController controller) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: AppColors.colorWhiteGray, width: 5),
      ),
      color: AppColors.colorWhite,
    ),
    child: Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImage(controller),
          _buildPriceProduct(controller),
          _buildNameProduct(controller),
          _buildQuantityProduct(controller),
        ],
      ),
    ),
  );
}

Widget _buildImage(DetailAndUpdateProductController controller) {
  final cover = controller.product.value?.cover;
  return Container(
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: AppColors.colorWhite,
      border: Border.all(color: AppColors.colorWhiteGray, width: 1),
    ),
    height: Get.height * 0.3,
    child: ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      child: (cover == null || cover.isEmpty)
          ? Image.asset(IconsAssets.noImage, fit: BoxFit.contain)
          : Image.network(cover, fit: BoxFit.contain),
    ),
  );
}

Widget _buildNameProduct(DetailAndUpdateProductController controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, bottom: 6, top: 16),
    child: TextUtils(
      text: controller.product.value?.name ?? '',
      size: AppDimens.sizeTextLarge,
      fontWeight: FontWeight.w800,
      color: AppColors.colorBlack,
    ),
  );
}

Widget _buildPriceProduct(DetailAndUpdateProductController controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, top: 16),
    child: TextUtils(
      text:
          '${controller.currencyFormatter.format(controller.product.value?.price ?? 0)}đ',
      size: AppDimens.sizeTextLarge,
      fontWeight: FontWeight.w800,
      color: AppColors.colorOrange,
    ),
  );
}

Widget _buildQuantityProduct(DetailAndUpdateProductController controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 6, top: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            TextUtils(
              text: 'Số lượng :',
              size: AppDimens.sizeTextMedium,
              fontWeight: FontWeight.w800,
              color: AppColors.colorBlack,
            ),
            SizedBoxCustom.h8,
            TextUtils(
              text: ' ${controller.product.value?.quantity ?? '0'}',
              size: AppDimens.sizeTextMediumTb,
              fontWeight: FontWeight.w600,
              color: AppColors.colorGray1,
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(IconsAssets.start),
            TextUtils(
              text: ' 5/5',
              size: AppDimens.sizeTextSmall,
              fontWeight: FontWeight.w800,
              color: AppColors.colorBlack,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBottomNavigationBar(DetailAndUpdateProductController controller) {
  return Container(
    padding: const EdgeInsets.fromLTRB(2, 16, 2, 21),
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: Color(0xffE0E0E0), width: 1)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buttonCartShopping(controller),
        SizedBoxCustom.w3,
        _buttonDelete(controller),
        SizedBoxCustom.w3,
        _buttonUpDate(controller),
      ],
    ),
  );
}

Widget _buttonCartShopping(DetailAndUpdateProductController controller) {
  return Expanded(
    child: UtilsWidget.buildButton(
      height: 54,
      text: AppStrings.shoppingCart,
      color: AppColors.colorGreen,
      textColor: AppColors.colorWhite,
      isIconText: true,
      asset: IconsAssets.shopping_cart_bag,
      border: Border.all(color: AppColors.colorGray, width: 1),
      onPressed: () {},
    ),
  );
}

Widget _buttonDelete(DetailAndUpdateProductController controller) {
  return Expanded(
    child: UtilsWidget.buildButton(
      height: 54,
      text: AppStrings.delete,
      color: AppColors.colorOrange,
      textColor: AppColors.colorWhite,
      isIconText: true,
      asset: IconsAssets.trash_can,
      border: Border.all(color: AppColors.colorGray, width: 1),
      onPressed: () async {
        final int? id = controller.product.value?.id;
        await controller.deleteProduct(id!);
      },
    ),
  );
}

Widget _buttonUpDate(DetailAndUpdateProductController controller) {
  return Expanded(
    child: UtilsWidget.buildButton(
      height: 54,
      text: AppStrings.update,
      textColor: AppColors.colorWhite,
      color: AppColors.colorOrange,
      isIconText: true,
      asset: IconsAssets.shopping_cart,
      border: Border.all(color: AppColors.colorGray, width: 1),
      onPressed: () async {
        final result = await Get.bottomSheet(
          ShowUpdate.showSheet(controller),
          isScrollControlled: true,
        );
        if (result != null) {
          controller.updateProduct(
            controller.product.value?.id,
            name: result['name'],
            price: int.parse(result['price']),
            quantity: int.parse(result['quantity']),
            coverUrl: result['cover'],
          );
        }
      },
    ),
  );
}
