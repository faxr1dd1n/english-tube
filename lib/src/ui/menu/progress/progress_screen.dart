import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/menu/progress/items/stat_barchart_widget.dart';
import 'package:en_tube/src/ui/menu/progress/items/stat_type_widget.dart';
import 'package:en_tube/src/ui/menu/progress/items/stat_widget.dart';
import 'package:en_tube/src/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.generalColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: 'Progress'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          //Initialize the spark charts widget
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatTypeWidget(),
              SizedBox(height: 10),
              StatBarchartWidget(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StatWidget(
                      title: 'Ko\'rilgan dars soati',
                      content: '12+ soat',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: StatWidget(
                      title: 'Ko\'rilgan darslar soni',
                      content: '2 dars',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
