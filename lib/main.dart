import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/router/app_router.dart';
import 'package:getx_curd/core/router/router_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: GoogleFonts.nunitoSans(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: const Color(0xff5C6771),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          shape: CircleBorder(),
          backgroundColor: Colors.white,
        ),
      ),
      getPages: RouterPage.router,
      initialRoute: AppRouter.routerSplash,
      // initialBinding: BindingsBuilder(() {
      //   Get.put<CartController>(CartController(), permanent: true);
      // }),
    );
  }
}
