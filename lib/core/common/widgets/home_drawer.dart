import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:iconsax/iconsax.dart';

import '../../../modules/customer/customer_controller.dart';
import '../../constraints/colors.dart';

class UDrawer extends StatelessWidget {
  const new({super.key, required this.controller});

  final CustomerController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: UColors.secondary,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [UColors.primary, UColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Iconsax.user),
            ),
            accountName: Text('Admin'),
            accountEmail: Text('admin@gmail.com'),
          ),

          ListTile(
            leading: Icon(Iconsax.people),
            title: Text('Customer List'),
            onTap: () {
              Get.back();
            },
          ),

          ListTile(
            leading: Icon(Iconsax.logout),
            title: Text('Logout'),
            onTap: () {
              Get.back();
              controller.search.clear();
              Get.offNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
