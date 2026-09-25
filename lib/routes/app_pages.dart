import 'package:customer_manage/modules/customer/customer_binding.dart';
import 'package:customer_manage/modules/customer/customer_list_view.dart';
import 'package:customer_manage/routes/app_routes.dart';
import 'package:get/get.dart';

import '../modules/auth/login_binding.dart';
import '../modules/auth/login_view.dart';

class AppPages {
  static const initial = AppRoutes.login;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.customerList,
      page: () => CustomerListView(),
      binding: CustomerBinding(),
    ),
  ];
}
