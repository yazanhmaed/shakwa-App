import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resources/color_manager.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class BarCharts extends StatefulWidget {
  BarCharts({super.key});

  final Color barBackgroundColor = Colors.white.withOpacity(0.3);
  final Color barColor = Colors.red;
  final Color touchedBarColor = Colors.amber;

  @override
  State<StatefulWidget> createState() => BarChartsState();
}

class BarChartsState extends State<BarCharts> {
  final Duration animDuration = const Duration(milliseconds: 1250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChartCubit()..getChart(),
      child: BlocBuilder<ChartCubit, ChartStates>(
        builder: (context, state) {
          var cubit = ChartCubit.get(context);
          List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
                switch (i) {
                  case 0:
                    return makeGroupData(0, cubit.jan,
                        isTouched: i == touchedIndex);
                  case 1:
                    return makeGroupData(1, cubit.feb,
                        isTouched: i == touchedIndex);
                  case 2:
                    return makeGroupData(2, cubit.mar,
                        isTouched: i == touchedIndex);
                  case 3:
                    return makeGroupData(3, cubit.apr,
                        isTouched: i == touchedIndex);
                  case 4:
                    return makeGroupData(4, cubit.may,
                        isTouched: i == touchedIndex);
                  case 5:
                    return makeGroupData(5, cubit.jun,
                        isTouched: i == touchedIndex);
                  case 6:
                    return makeGroupData(6, cubit.jul,
                        isTouched: i == touchedIndex);
                  case 7:
                    return makeGroupData(7, cubit.aug,
                        isTouched: i == touchedIndex);
                  case 8:
                    return makeGroupData(8, cubit.sept,
                        isTouched: i == touchedIndex);
                  case 9:
                    return makeGroupData(9, cubit.oct,
                        isTouched: i == touchedIndex);
                  case 10:
                    return makeGroupData(10, cubit.nov,
                        isTouched: i == touchedIndex);
                  case 11:
                    return makeGroupData(11, cubit.dec,
                        isTouched: i == touchedIndex);
                  default:
                    return throw Error();
                }
              });
          BarChartData mainBarData() {
            return BarChartData(
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.blueGrey,
                  tooltipHorizontalAlignment: FLHorizontalAlignment.right,
                  tooltipMargin: -10,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String monthTime;
                    switch (group.x) {
                      case 0:
                        monthTime = 'January ';
                        break;
                      case 1:
                        monthTime = 'February ';
                        break;
                      case 2:
                        monthTime = 'March';
                        break;
                      case 3:
                        monthTime = 'April ';
                        break;
                      case 4:
                        monthTime = 'May  ';
                        break;
                      case 5:
                        monthTime = 'June  ';
                        break;
                      case 6:
                        monthTime = 'July  ';
                        break;
                      case 7:
                        monthTime = 'August  ';
                        break;
                      case 8:
                        monthTime = 'September ';
                        break;
                      case 9:
                        monthTime = 'October ';
                        break;
                      case 10:
                        monthTime = 'November ';
                        break;
                      case 11:
                        monthTime = 'December ';
                        break;

                      default:
                        throw Error();
                    }
                    return BarTooltipItem(
                      '$monthTime\n',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: (rod.toY.toInt() - 1).toString(),
                          style: TextStyle(
                            color: widget.touchedBarColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                touchCallback: (FlTouchEvent event, barTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        barTouchResponse == null ||
                        barTouchResponse.spot == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                  });
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: getTitles,
                    reservedSize: 50,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: showingGroups(),
              gridData: FlGridData(show: false),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 1.3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorManager.primary,
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const Text(
                            'Monthly Complaints',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: BarChart(
                                mainBarData(),
                                swapAnimationDuration: animDuration,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    int y, {
    bool isTouched = false,
    Color? barColor,
    double width = 25,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y.toDouble() + 1 : y.toDouble(),
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Jan', style: style);
        break;
      case 1:
        text = const Text('Feb', style: style);
        break;
      case 2:
        text = const Text('Mar', style: style);
        break;
      case 3:
        text = const Text('Apr', style: style);
        break;
      case 4:
        text = const Text('May', style: style);
        break;
      case 5:
        text = const Text('Jun', style: style);
        break;
      case 6:
        text = const Text('Jul', style: style);
        break;
      case 7:
        text = const Text('Aug', style: style);
        break;
      case 8:
        text = const Text('Sept', style: style);
        break;
      case 9:
        text = const Text('Oct', style: style);
        break;
      case 10:
        text = const Text('Nov', style: style);
        break;
      case 11:
        text = const Text('Dec', style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
