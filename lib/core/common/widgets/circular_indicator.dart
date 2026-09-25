import 'package:flutter/material.dart';

import '../../constraints/colors.dart';

class UCircularProgressIndicator extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: UColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
