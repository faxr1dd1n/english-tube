import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProgressUsersRanking extends StatefulWidget {
  const ProgressUsersRanking({super.key});

  @override
  State<ProgressUsersRanking> createState() => _ProgressUsersRankingState();
}

class _ProgressUsersRankingState extends State<ProgressUsersRanking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: translate('progress.title')),
      ),
      body: ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        itemCount: 25,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: AppColor.blue,
                child: Text('U', style: TextStyle(fontSize: 22)),
              ),
              title: Text('User name'),
              subtitle: Text('Subtitle'),
            ),
          );
        },
      ),
    );
  }
}
