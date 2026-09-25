import 'package:flutter/material.dart';

class USocialButton extends StatelessWidget {
  const USocialButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(indent: 60, endIndent: 5)),
            Text('Or Sign In With'),
            Expanded(child: Divider(indent: 5, endIndent: 60)),
          ],
        ),
        SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Image.network(
              'https://cdn-icons-png.flaticon.com/128/2702/2702602.png',
              height: 46,
              width: 46,
            ),
          ),
        ),
      ],
    );
  }
}
