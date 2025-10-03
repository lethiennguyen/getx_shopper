part of 'shopping_cart_page.dart';

Widget _buildShoppingCart(ShoppingCartController controller) {
  return ValueListenableBuilder(
    valueListenable: controller.box.listenable(),
    builder: (context, Box<CartItem> box, _) {
      final items = box.values.toList();
      if (items.isEmpty) {
        return Container(
          decoration: BoxDecoration(color: AppColors.colorWhite),
          child: Center(child: Text(AppStrings.emptyCart)),
        );
      }
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: _itemProduct(controller, item),
          );
        },
      );
    },
  );
}

Widget _itemProduct(ShoppingCartController controller, CartItem items) {
  final id = items.id;
  return Slidable(
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          flex: 2,
          onPressed: (context) {
            controller.removeById(id);
          },
          backgroundColor: AppColors.colorOrange2,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: AppStrings.delete,
        ),
      ],
    ),
    child: Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: UtilsWidget.formProductItem(
        ShoppingCartOperationModel(
          name: items.name ?? '',
          price: items.price,
          totalPrice: items.price * items.quantity,
          quantity: items.quantity ?? 0,
          cover: items.cover ?? '',
          onIncrease: () {
            controller.quantityChange(id, true);
          },
          onReduce: () {
            controller.quantityChange(id, false);
          },
          onChange: (v) => {controller.selectById(items.id, v ?? false)},
          isCheckBox: items.checked,
        ),
      ),
    ),
  );
}

Widget _bottomNavigatorBar(ShoppingCartController controller) {
  return Container(
    height: 120,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(top: BorderSide(color: Color(0xffF7F7F7), width: 1)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: Obx(
                  () => Checkbox(
                    value: controller.checkAll.value,
                    onChanged: (val) {
                      controller.selectAll(val ?? false);
                    },
                    activeColor: AppColors.colorOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              SizedBoxCustom.w4,
              TextUtils(
                text: AppStrings.allCheck,
                size: AppDimens.sizeTextSmall,
                fontWeight: FontWeight.w500,
                color: AppColors.colorGray,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextUtils(
                  text: AppStrings.totalAmount,
                  size: AppDimens.sizeTextSmaller,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
                SizedBoxCustom.h2,
                Obx(
                  () => TextUtils(
                    text: CurrencyUtils.formatPrice(
                      controller.sumItem.value,
                    ).toString(),
                    size: AppDimens.sizeTextMediumTb,
                    fontWeight: FontWeight.w700,
                    color: AppColors.colorOrange,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: UtilsWidget.buildButton(
            text: AppStrings.purchase,
            height: 54,
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}

PreferredSizeWidget _appBar(ShoppingCartController controller) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        if (controller.deletedSomething.value) {
          Get.back(result: true);
        } else {
          Get.back();
        }
      },
      icon: Icon(Icons.arrow_back_ios_new),
    ),
    backgroundColor: Colors.white,
    title: TextUtils(
      text: AppStrings.cart,
      availableStyle: StyleEnum.MbTitle1Bold,
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1),
      child: Container(color: Colors.black26, height: 0.5),
    ),
    actions: [
      IconButton(
        onPressed: () {
          controller.removeSelected();
        },
        icon: Icon(Icons.delete, color: AppColors.colorOrange),
      ),
      SizedBox(width: 8),
    ],
  );
}
