import 'dart:convert';

import 'package:customer_manage/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  // Add controller
  final email = TextEditingController(text: "admin@gmail.com");
  final password = TextEditingController(text: 'admin1234');
  final loginFormKey = GlobalKey<FormState>();

  final isPasswordVisible = false.obs;
  final remember = false.obs;
  final isLoading = false.obs;

  String token = '';

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      Uri url = Uri.parse(
        'https://www.hisabplus.com/Values/LogIn?UserName=${email.text.trim()}&Password=${password.text.trim()}&ComId=1',
      );
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        debugPrint(response.statusCode.toString());
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['Token'] != null) {
          token = data['Token'];
          Get.offNamed(AppRoutes.customerList, arguments: token);
        } else {
          Get.snackbar('Error', 'Invalid email or password');
        }
      } else {
        Get.snackbar('Error', 'Server error ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server');
    } finally {
      isLoading.value = false;
    }
  }
}
