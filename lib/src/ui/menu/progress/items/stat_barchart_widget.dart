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
      _ChartData('Dush', 1),
      _ChartData('Sesh', 2),
      _ChartData('Chor', 2),
      _ChartData('Pay', 4),
      _ChartData('Juma', 5.5),
      _ChartData('Shan', 2.3),
      _ChartData('Yak', 4),
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
          name: 'Soat',
          color: Color.fromRGBO(239, 158, 19, 1),
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
