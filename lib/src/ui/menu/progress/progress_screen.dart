import 'package:en_tube/src/constraints/app_color.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('Dush', 12),
      _ChartData('Sesh', 15),
      _ChartData('Chor', 30),
      _ChartData('Pay', 6.4),
      _ChartData('Juma', 14),
      _ChartData('Shan', 14),
      _ChartData('Yak', 14),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.geeralColor,
      appBar: AppBar(
        backgroundColor: AppColor.geeralColor,
        elevation: 2,
        shadowColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
        title: const Text('Progress', style: TextStyle(color: AppColor.white)),
      ),
      body: SingleChildScrollView(
        
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          //Initialize the spark charts widget
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Haftalik hisobot',
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12),
              SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  labelStyle: TextStyle(color: AppColor.white),
                ),
                primaryYAxis: NumericAxis(
                  labelStyle: TextStyle(color: AppColor.white),
                  minimum: 0,
                  maximum: 24,
                  interval: 1,
                ),
                tooltipBehavior: _tooltip,
        
                series: <CartesianSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: data,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    name: 'Soat',
                    color: Color.fromRGBO(239, 158, 19, 1),
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

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
