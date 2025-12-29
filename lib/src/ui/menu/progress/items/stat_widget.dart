import 'package:en_tube/src/constraints/app_color.dart';
import 'package:flutter/material.dart';

class StatWidget extends StatelessWidget {
  const StatWidget({required this.title,required this.content,super.key});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blue],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        // color: AppColor.gray700,
      ),
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      // width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColor.white,
            ),
          ),
          SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }
}
