import 'package:en_tube/src/constraints/app_color.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({this.onTap, this.titleText, this.buttonText, super.key});
  final Function()? onTap;
  final String? titleText;
  final String? buttonText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleText ?? '',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColor.white,
          ),
        ),
        TextButton(
          onPressed: onTap ?? () {},
          child: Text(
            buttonText ?? '',
            style: const TextStyle(
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
