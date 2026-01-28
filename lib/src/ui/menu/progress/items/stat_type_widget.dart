import 'package:flutter_translate/flutter_translate.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:flutter/material.dart';

class StatTypeWidget extends StatefulWidget {
  const StatTypeWidget({super.key});

  @override
  State<StatTypeWidget> createState() => _StatTypeWidgetState();
}

class _StatTypeWidgetState extends State<StatTypeWidget> {
  int selectedType = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.gray600,
      ),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      height: 40,

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (selectedType != 0) {
                setState(() {
                  selectedType = 0;
                });
              }
            },
            child: selectedType == 0
                ? Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.gray500,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Center(
                      child: Text(
                        translate('progress.weekly'),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColor.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      translate('progress.weekly'),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColor.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
          ),
          SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              if (selectedType != 1) {
                setState(() {
                  selectedType = 1;
                });
              }
            },
            child: selectedType == 1
                ? Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.gray500,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Center(
                      child: Text(
                        translate('progress.daily'),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColor.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      translate('progress.daily'),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColor.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
