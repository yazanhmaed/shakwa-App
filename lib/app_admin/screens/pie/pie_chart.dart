import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pro_test/resources/components.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/string_manager.dart';
import 'bar_chart.dart';
import 'indicator.dart';

class PieCharts extends StatefulWidget {
  const PieCharts(
      {super.key,
      required this.waiting,
      required this.prosses,
      required this.success,
      required this.wcount,
      required this.pcount,
      required this.scount});
  final double waiting;
  final double prosses;
  final double success;
  final int wcount;
  final int pcount;
  final int scount;

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieCharts> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppString.complaintBackground),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: draw == true
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              BarCharts(),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  'Complaints Statistics',
                  style: TextStyle(
                      color: ColorManager.primary, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1.6,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 2,
                          centerSpaceRadius: 0,
                          sections: showingSections(
                              waiting: widget.waiting,
                              prosses: widget.prosses,
                              success: widget.success),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  color: ColorManager.white.withOpacity(0.7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Indicator(
                        count: '${widget.wcount}',
                        color: Colors.red,
                        text: 'Waiting',
                        isSquare: false,
                        size: touchedIndex == 0 ? 25 : 16,
                        textColor: touchedIndex == 0
                            ? Colors.red
                            : Colors.red.shade500,
                      ),
                      Indicator(
                        count: '${widget.pcount}',
                        color: Colors.amber,
                        text: 'Prosses',
                        isSquare: false,
                        size: touchedIndex == 1 ? 25 : 16,
                        textColor: touchedIndex == 1
                            ? Colors.amber
                            : Colors.amber.shade500,
                      ),
                      Indicator(
                        count: '${widget.scount}',
                        color: ColorManager.primary,
                        text: 'Succsess',
                        isSquare: false,
                        size: touchedIndex == 2 ? 25 : 16,
                        textColor: touchedIndex == 2
                            ? Colors.green
                            : Colors.green.shade500,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections({
    required double waiting,
    required double prosses,
    required double success,
  }) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 160.0 : 150.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: waiting,
            title: '${waiting.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.amber,
            value: prosses,
            title: '${prosses.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: ColorManager.primary,
            value: success,
            title: '${success.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );

        default:
          throw Error();
      }
    });
  }
}
