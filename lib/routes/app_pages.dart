import 'package:flutter_wan_android_getx/page/index/index_binding.dart';
import 'package:flutter_wan_android_getx/page/index/index_page.dart';
import 'package:flutter_wan_android_getx/page/unknown_route_page.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final unknownRoute = GetPage(
    name: AppRoutes.unknownRoutePage,
    page: () => const UnKnownRoutePage(),
  );

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.main,
      page: () => const IndexPage(),
      binding: IndexBinding(),
    ),
  ];
}
