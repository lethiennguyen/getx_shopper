part of 'list_product_page.dart';

Widget _buildListProduct(ListProductController controller) {
  return Obx(() {
    // if (controller.isShowLoading.value) {
    //   return _buildSkeletonListProduct();
    // }
    if (controller.listProduct.isEmpty) {
      return _noData(controller);
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

Widget _noData(ListProductController controller) {
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
              controller.onRefresh();
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
        return _buildProductSkeleton();
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
            if (result == true) {
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
                              text: controller.formatPrice(product.price ?? 0),
                              size: AppDimens.sizeText13,
                              fontWeight: FontWeight.w900,
                              color: AppColors.colorOrange,
                            ),
                            GestureDetector(
                              onTap: () {},
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

Widget _buildProductSkeleton() {
  return Padding(
    padding: const EdgeInsets.all(4),
    child: Material(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffEBEBEB)),
        ),
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
              child: Skeletonizer(
                enabled: true,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: double.infinity,
                  ),
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
                    SizedBoxCustom.h8,
                    Skeletonizer(
                      enabled: true,
                      child: Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
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
                          Skeletonizer(
                            enabled: true,
                            child: Container(
                              height: 14,
                              width: 60,
                              color: Colors.grey[300],
                            ),
                          ),
                          Skeletonizer(
                            enabled: true,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 15,
                                color: Colors.transparent,
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
  );
}

PreferredSizeWidget _appBar() {
  return AppBar(
    title: SvgPicture.asset(IconsAssets.logo, width: 158, height: 37),
    backgroundColor: AppColors.colorWhite,
    elevation: 0,
    actions: [
      Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            UtilsWidget.buildIconShoppingCart(
              onPressed: () {
                HapticFeedback.lightImpact();
              },
              numberItem: '12',
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
