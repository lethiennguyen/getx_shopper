import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:getx_curd/core/router/app_router.dart';
import 'package:getx_curd/features/app/app_page.dart';
import 'package:getx_curd/features/create_product/views/create_product_page.dart';
import 'package:getx_curd/features/detail_product/views/detail_product_page.dart';
import 'package:getx_curd/features/home/views/home_page.dart';
import 'package:getx_curd/features/login/views/login_page.dart';
import 'package:getx_curd/features/shopping_cart/views/shopping_cart_page.dart';
import '../../features/app/controller/binding.dart';
import '../../features/list_product/views/list_product_page.dart';

class RouterPage {
  static var router = [
    GetPage(
      name: AppRouter.routerSplash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),

    GetPage(name: AppRouter.routerLogin, page: () => const MyHomeLogin()),
    GetPage(name: AppRouter.routerHome, page: () => const MyHomePage()),
    GetPage(
      name: AppRouter.routerProduct_detail,
      page: () => const DetailProductPage(),
    ),
    GetPage(
      name: AppRouter.routerCreat_product,
      page: () => const CreateProductPage(),
    ),
    GetPage(
      name: AppRouter.routerShopping_cart,
      page: () => const ShoppingCartPage(),
    ),
    GetPage(
      name: AppRouter.routerPageListProduct,
      page: () => const ListProductPage(),
    ),
  ];
}
