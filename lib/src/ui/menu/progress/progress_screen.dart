import 'package:en_tube/src/ui/menu/progress/pages/progress_users_ranking.dart';
import 'package:en_tube/src/widgets/title_widget.dart';
import 'package:en_tube/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:en_tube/src/ui/menu/progress/line_chart_sample.dart';
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
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: tr('progress.title')),
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
              LineChartSample(),
              SizedBox(height: 20),
              TitleWidget(
                titleText: 'Users ranking',
                buttonText: 'See all',

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProgressUsersRanking();
                      },
                    ),
                  );
                },
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 40,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(right: 8, left: 8),
                            trailing: Text(
                              ((100 + index) / (1 + index)).toInt().toString(),
                              style: TextStyle(
                                color: AppColors.textOnPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.blue,
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textOnPrimary,
                                ),
                              ),
                            ),
                            title: Text(
                              'User name',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textOnPrimary,
                              ),
                            ),
                            subtitle: Text(
                              'Subtitle',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textOnPrimary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: IgnorePointer(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.darkBackground.withOpacity(0.99),
                              blurRadius: 25,
                              spreadRadius: 12,
                              offset: Offset(0, -6),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              // ProgressUsersRanking(),
              SizedBox(height: 20),
              StatBarchartWidget(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StatWidget(
                      title: tr('progress.watched_hours'),
                      content: tr('progress.hours_value'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: StatWidget(
                      title: tr('progress.watched_lessons'),
                      content: tr('progress.lessons_value'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
