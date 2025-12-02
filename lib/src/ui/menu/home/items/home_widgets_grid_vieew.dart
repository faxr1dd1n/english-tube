import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/model/home_wdget_model.dart';
import 'package:flutter/material.dart';

class HomeWidgetsGridVieew extends StatelessWidget {
  const HomeWidgetsGridVieew({required this.widgetModel, super.key});

  final List<HomeWidgetModel> widgetModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 90,
      child: GridView.builder(
        itemCount: widgetModel.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 14,
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 80,
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widgetModel[index].imageUrl == "translate"
                      ? Icons.translate     
                      : widgetModel[index].imageUrl == "listening"
                      ? Icons.headset_outlined
                      : widgetModel[index].imageUrl == "reading"
                      ? Icons.menu_book_rounded
                      : widgetModel[index].imageUrl == "speaking"
                      ? Icons.record_voice_over_rounded
                      : Icons.help_outline,
                  color: AppColor.blue,
                  size: 35,
                ),
                SizedBox(height: 6),
                Text(
                  widgetModel[index].title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.dark,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
