part of 'list_product_page.dart';

Widget _buildListProduct(ListProductController controller) {
  return Obx(() {
    if (controller.isShowLoading.value) {
      return _buildSkeletonListProduct();
    }
    if (controller.listProduct.isEmpty) {
      return _noData(controller.onRefresh);
    }
    return UtilsWidget.buildSmartRefresher(
      refreshController: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoadMore: controller.onLoadMore,
      enablePullDown: true,
      enablePullUp: controller.isLoadMore.value,
      child: _buildItemProduct(controller),
    );
  });
}

Widget _buildItemProduct(ListProductController controller) {
  return GridView.builder(
    padding: const EdgeInsets.all(8),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      childAspectRatio: 3 / 4.5,
    ),
    itemCount: controller.listProduct.length,
    itemBuilder: (context, index) {
      return _productItem(controller.listProduct[index], controller);
    },
  );
}

Widget _noData(VoidCallback func) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 80, color: AppColors.colorOrange),
          TextUtils(
            text: AppStrings.textNoProduct,
            fontStyle: FontStyle.italic,
            size: AppDimens.fontMedium(),
            fontWeight: FontWeight.w700,
            color: Colors.black54,
          ),
          SizedBoxCustom.h16,
          ElevatedButton(
            onPressed: () {
              func.call();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const TextUtils(
              text: AppStrings.textLoading,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildSkeletonListProduct() {
  return Skeletonizer(
    child: GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 3 / 4.5,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return ProductSkeleton();
      },
    ),
  );
}

Widget _productItem(ProductData product, ListProductController controller) {
  return Padding(
    padding: const EdgeInsets.all(4),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.grey.withOpacity(0.1),
          onTap: () async {
            await Future.delayed(const Duration(milliseconds: 100));
            final result = await Get.toNamed(
              AppRouter.routerProduct_detail,
              arguments: product.id,
            );
            if (result) {
              controller.onRefresh();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 160,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xffEBEBEB), width: 1),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    product.cover ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBoxCustom.h2,
                      TextUtils(
                        text: product.name ?? '',
                        size: AppDimens.sizeTextSmallTb,
                        fontWeight: FontWeight.w700,
                        color: AppColors.colorBlack,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16,
                          top: 8,
                          right: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextUtils(
                              text: CurrencyUtils.formatPriceDigits(
                                product.price ?? 0,
                              ),
                              size: AppDimens.sizeText13,
                              fontWeight: FontWeight.w900,
                              color: AppColors.colorOrange,
                            ),
                            GestureDetector(
                              onTap: () {
                                final id = product.id;
                                if (product.id != null) {
                                  final item = CartItem(
                                    id: id!,
                                    name: product.name!,
                                    price: product.price!,
                                    quantity: 1,
                                    cover: product.cover!,
                                    checked: false,
                                  );
                                  controller.addItem(item);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.colorOrange,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

PreferredSizeWidget _appBar(ListProductController controller) {
  return AppBar(
    title: SvgPicture.asset(IconsAssets.logo, width: 158, height: 37),
    backgroundColor: AppColors.colorWhite,
    elevation: 0,
    actions: [
      Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            Obx(
              () => UtilsWidget.buildIconShoppingCart(
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  final result = await Get.toNamed(
                    AppRouter.routerShopping_cart,
                  );
                  if (result == true) {
                    controller.shoppingCartCount();
                  }
                },
                numberItem: controller.cartCount.toString(),
              ),
            ),
          ],
        ),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1),
      child: Container(color: AppColors.colorWhiteGray, height: 1),
    ),
  );
}

Widget _buildFloatingActionButton(VoidCallback func) {
  return FloatingActionButton(
    backgroundColor: AppColors.colorOrange,
    child: Icon(Icons.add, color: Colors.white),
    onPressed: () async {
      final result = await Get.toNamed(AppRouter.routerCreat_product);
      if (result == true) {
        func.call();
      }
    },
  );
}
