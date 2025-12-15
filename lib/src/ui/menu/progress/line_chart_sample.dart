import 'package:en_tube/src/constraints/app_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LineChartSample extends StatefulWidget {
  const LineChartSample({super.key});

  @override
  State<LineChartSample> createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  final List<Color> gradientColors = [AppColor.green500, AppColor.green600];

  bool showAvg = false;

  // Scroll uchun - joriy oyning kunlari
  late final double totalDataPoints;
  final double viewportSize = 9; // Ekranda 9 kun
  late double scrollPosition;

  @override
  void initState() {
    super.initState();
    // Faqat bugungi kungacha
    final now = DateTime.now();
    totalDataPoints = now.day.toDouble(); // Bugungi kun
    scrollPosition = totalDataPoints; // Oxiridan boshlash
  }

  // Dinamik data yaratish - soatlar (0-10)
  List<FlSpot> generateMonthData() {
    final List<FlSpot> spots = [];
    for (int day = 1; day <= totalDataPoints.toInt(); day++) {
      // Random yoki API'dan kelgan data (0-10 soat)
      final double hours = (day % 5 + (day % 3) * 1.5 + 2).clamp(0.0, 10.0);
      spots.add(FlSpot(day.toDouble(), hours));
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(18.0),
        color: AppColor.gray800,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.70,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 8,
                left: 0,
                top: 30,
                bottom: 12,
              ),
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    // Oddiy scroll - chegarada to'xtaydi
                    final double sensitivity = 30.0;
                    scrollPosition -= details.delta.dx / sensitivity;
                    // Chegarani clamp qilish - bugundan o'tmaydi
                    scrollPosition = scrollPosition.clamp(
                      viewportSize,
                      totalDataPoints,
                    );
                  });
                },
                child: LineChart(
                  showAvg ? avgData() : mainData(),
                  duration: Duration.zero,
                ),
              ),
            ),
          ),
          Positioned(
            top: -15,

            left: -15,
            child: SizedBox(
              width: 60,
              height: 34,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showAvg = !showAvg;
                  });
                },
                child: Text(
                  'avg',
                  style: TextStyle(
                    fontSize: 12,
                    color: showAvg
                        ? Colors.white.withValues(alpha: 0.5)
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 9,
      color: Colors.white,
    );

    // Faqat butun sonlar uchun (15.0 = ok, 15.5 = yo'q)
    if ((value - value.round()).abs() > 0.01) {
      return const SizedBox();
    }

    final int day = value.toInt();
    if (day >= 1 && day <= totalDataPoints.toInt()) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text('$day', style: style),
      );
    }
    return const SizedBox();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 10,
      color: Colors.white,
    );
    // Soatlar: 0, 2, 4, 6, 8, 10+
    if (value % 2 == 0 && value >= 0 && value <= 10) {
      final label = value == 10 ? '10+' : '${value.toInt()}';
      return Text(label, style: style, textAlign: TextAlign.left);
    }
    return const SizedBox();
  }

  LineChartData mainData() {
    return LineChartData(
      // Touch indicator - nozik va chiroyli
      lineTouchData: LineTouchData(
        touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
          if (response?.lineBarSpots != null &&
              response!.lineBarSpots!.isNotEmpty) {
            // User nuqtani tanladi - bu yerda vibrate qiling
            HapticFeedback.selectionClick(); // yoki HapticFeedback.lightImpact()
          }
        },

        // ... qolgan kod
        enabled: true,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
              return spotIndexes.map((index) {
                return TouchedSpotIndicatorData(
                  // Vertikal line - juda nozik
                  FlLine(
                    color: AppColor.white.withValues(alpha: 0.5),
                    strokeWidth: 1,
                  ),
                  // Nuqta - kichik
                  FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 3,
                        color: AppColor.green600,
                        strokeWidth: 2,
                        strokeColor: AppColor.green400,
                      );
                    },
                  ),
                );
              }).toList();
            },
        touchTooltipData: LineTouchTooltipData(
          tooltipRoundedRadius: 8,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                spot.y.toStringAsFixed(1),
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              );
            }).toList();
          },
        ),
        touchSpotThreshold: 15,
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 2, // Y axis: har 2 soatda (0, 2, 4, 6, 8, 10)
        verticalInterval: 1, // X axis: har kun
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white.withValues(alpha: 0.1),
            strokeWidth: 0.2,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white.withValues(alpha: 0.1),
            strokeWidth: 0.2,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 28,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      minX: scrollPosition - viewportSize + 1,
      maxX: scrollPosition,
      minY: 0,
      maxY: 10, // Maksimal 10 soat
      lineBarsData: [
        LineChartBarData(
          spots: generateMonthData(), // Dinamik bugungi kungacha
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 1.5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                gradientColors[1].withValues(alpha: 0.4), // Yuqorida to'q rang
                gradientColors[0].withValues(alpha: 0.10), // O'rtada
                gradientColors[0].withValues(
                  alpha: 0.0,
                ), // Eng pasti deyarli rangsiz
              ],
              stops: const [0.0, 0.70, 1.0], // 70% dan boshlab rangsizlanadi
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 2, // Har 2 soatda
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white.withValues(alpha: 0.1),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white.withValues(alpha: 0.1),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      minX: scrollPosition - viewportSize + 1,
      maxX: scrollPosition + 0.1,
      minY: 0,
      maxY: 10, // Maksimal 10 soat
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(
                begin: gradientColors[0],
                end: gradientColors[1],
              ).lerp(0.2)!,
              ColorTween(
                begin: gradientColors[0],
                end: gradientColors[1],
              ).lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(
                  begin: gradientColors[0],
                  end: gradientColors[1],
                ).lerp(0.2)!.withValues(alpha: 0.1),
                ColorTween(
                  begin: gradientColors[0],
                  end: gradientColors[1],
                ).lerp(0.2)!.withValues(alpha: 0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
