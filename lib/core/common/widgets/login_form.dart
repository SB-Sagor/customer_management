import 'package:customer_manage/core/common/widgets/circular_indicator.dart';
import 'package:customer_manage/modules/auth/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'elevated_button.dart';

class ULoginForm extends StatelessWidget {
  ULoginForm({super.key});
  final controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
                value == null || value.isEmpty ? 'Email is required' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: 'email',
            ),
          ),
          SizedBox(height: 12),
          Obx(
            () => TextFormField(
              controller: controller.password,
              obscureText: !controller.isPasswordVisible.value,
              validator: (value) => value == null || value.isEmpty
                  ? 'Password is required'
                  : null,

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                prefixIcon: Icon(Iconsax.password_check),
                labelText: 'password',
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Iconsax.eye
                        : Iconsax.eye_slash,
                  ),
                  onPressed: controller.isPasswordVisible.toggle,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.remember.value,
                      onChanged: (value) =>
                          controller.remember.value = value ?? false,
                    ),
                  ),
                  Text('Remember me'),
                ],
              ),

              TextButton(onPressed: () {}, child: Text('Forget Password')),
            ],
          ),
          SizedBox(height: 24),
          Obx(
            () => UElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.login,
              child: controller.isLoading.value
                  ? UCircularProgressIndicator()
                  : Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: () {
                Get.snackbar(
                  'Notice',
                  'Registration is managed by organization admin.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                shadowColor: Colors.blue.withValues(alpha: 0.2),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Create Account'),
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
