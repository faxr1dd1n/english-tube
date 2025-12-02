import 'package:en_tube/src/constraints/app_color.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Yangi kurslar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColor.white,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Barchasi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColor.blue,
            ),
          ),
        ),
      ],
    );
  }
}
