import 'package:flutter_translate/flutter_translate.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/model/home_widget_model.dart';
import 'package:flutter/material.dart';

class HomeWidgetsGridVieew extends StatelessWidget {
  const HomeWidgetsGridVieew({required this.widgetModel, super.key});

  final List<HomeWidgetModel> widgetModel;

  String _getTranslatedTitle(String imageUrl) {
    switch (imageUrl.toLowerCase()) {
      case 'translate':
        return translate('skills.translate');
      case 'listening':
        return translate('skills.listening');
      case 'reading':
        return translate('skills.reading');
      case 'speaking':
        return translate('skills.speaking');
      default:
        return imageUrl;
    }
  }

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
                gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
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
                  color: AppColor.white,
                  size: 35,
                ),
                const SizedBox(height: 6),
                Text(
                  _getTranslatedTitle(widgetModel[index].imageUrl),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white,
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
