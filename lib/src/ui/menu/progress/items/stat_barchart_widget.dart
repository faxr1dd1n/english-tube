import 'package:easy_localization/easy_localization.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatBarchartWidget extends StatefulWidget {
  const StatBarchartWidget({super.key});

  @override
  State<StatBarchartWidget> createState() => _StatBarchartWidgetState();
}

class _StatBarchartWidgetState extends State<StatBarchartWidget> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    super.initState();

    data = [
      _ChartData('progress.monday'.tr(), 1),
      _ChartData('progress.tuesday'.tr(), 2),
      _ChartData('progress.wednesday'.tr(), 2),
      _ChartData('progress.thursday'.tr(), 4),
      _ChartData('progress.friday'.tr(), 5.5),
      _ChartData('progress.saturday'.tr(), 2.3),
      _ChartData('progress.sunday'.tr(), 4),
    ];
    _tooltip = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderColor: Colors.transparent,
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(color: Colors.transparent),
        labelStyle: TextStyle(color: AppColor.white),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: TextStyle(color: AppColor.white),
        majorGridLines: MajorGridLines(color: AppColor.blue),
        minimum: 0,
        maximum: 8,
        interval: 1,
      ),
      tooltipBehavior: _tooltip,

      series: <CartesianSeries<_ChartData, String>>[
        ColumnSeries<_ChartData, String>(
          dataSource: data,
          xValueMapper: (_ChartData data, _) => data.x,
          yValueMapper: (_ChartData data, _) => data.y,
          name: 'progress.hours'.tr(),
          color: const Color.fromRGBO(239, 158, 19, 1),
        ),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
