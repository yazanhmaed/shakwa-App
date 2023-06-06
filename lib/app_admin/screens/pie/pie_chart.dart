import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pro_test/app_admin/screens/pie/row_chart.dart';


import '../../../resources/color_manager.dart';
import '../../../resources/components.dart';
import '../../../resources/string_manager.dart';

import '../../../translations/locale_keys.g.dart';
import '../communications/cubit/cubit.dart';
import '../cybercrimes/cubit/cubit.dart';
import '../home_screen/cubit/cubit.dart';
import '../view_complaints_admin/view_filter.dart';
import '../view_complaints_admin/view_filtter_comm.dart';
import '../view_complaints_admin/view_filtter_cyber.dart';
import 'bar_chart.dart';
import 'indicator.dart';

class PieCharts extends StatefulWidget {
  const PieCharts({
    super.key,
    required this.waiting,
    required this.prosses,
    required this.success,
    required this.wcount,
    required this.pcount,
    required this.scount,
    required this.s1,
    required this.s2,
    required this.s3,
    required this.s4,
    required this.s5,
    required this.rate,
    this.cubit,
    this.cubitCrimes,
    this.cubitComm,
  });
  final double waiting;
  final double prosses;
  final double success;
  final int wcount;
  final int pcount;
  final int scount;
  final int s1;
  final int s2;
  final int s3;
  final int s4;
  final int s5;
  final double rate;
  final ComplaintsCubit? cubit;
  final CyberCrimesCubit? cubitCrimes;
  final CommunicationsCubit? cubitComm;

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieCharts> {
  int touchedIndex = -1;
  List<Widget> icon = [
    Icon(
      Icons.sentiment_very_dissatisfied,
      color: Colors.red,
      size: 5,
    ),
    Icon(
      Icons.sentiment_dissatisfied,
      color: Colors.redAccent,
      size: 5,
    ),
    Icon(
      Icons.sentiment_neutral,
      color: Colors.amber,
      size: 5,
    ),
    Icon(
      Icons.sentiment_satisfied,
      color: Colors.lightGreen,
      size: 5,
    ),
    Icon(
      Icons.sentiment_very_satisfied,
      color: Colors.green,
      size: 5,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Analytics.tr()),
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorManager.primary,
                ),
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 8),
                        ReviewChart(
                            label: '5',
                            pct: widget.s5,
                            iconData: Icons.sentiment_very_satisfied),
                        SizedBox(height: 2),
                        ReviewChart(
                            label: '4',
                            pct: widget.s4,
                            iconData: Icons.sentiment_satisfied),
                        SizedBox(height: 2),
                        ReviewChart(
                            label: '3',
                            pct: widget.s3,
                            iconData: Icons.sentiment_neutral),
                        SizedBox(height: 2),
                        ReviewChart(
                            label: '2',
                            pct: widget.s2,
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 2),
                        ReviewChart(
                            label: '1',
                            pct: widget.s1,
                            iconData: Icons.sentiment_very_dissatisfied),
                        SizedBox(height: 8),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.rate.toStringAsFixed(1)}',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          LocaleKeys.Rate.tr(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Text(
                      LocaleKeys.Statistics.tr(),
                      style: TextStyle(
                          color: ColorManager.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
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
                      GestureDetector(
                        onTap: () {
                          if (uIdA == 'AntiCyberCrimesUnit') {
                            if (widget.cubitCrimes!.waiting.isNotEmpty)
                              navigateTo(
                                  context,
                                  ViewFilterCyber(
                                    title: LocaleKeys.waiting.tr(),
                                    cyberCrimes: widget.cubitCrimes,
                                    list: widget.cubitCrimes!.waiting,
                                  ));
                          } else if (uIdA == 'MinistryofCommunications') {
                            if (widget.cubitComm!.waiting.isNotEmpty)
                              navigateTo(
                                  context,
                                  ViewFilterComm(
                                    title: LocaleKeys.waiting.tr(),
                                    commCubit: widget.cubitComm,
                                    list: widget.cubitComm!.waiting,
                                  ));
                          } else {
                            if (widget.cubit!.waiting.isNotEmpty)
                              navigateTo(
                                  context,
                                  ViewFilter(
                                    title: LocaleKeys.waiting.tr(),
                                    cubit: widget.cubit,
                                    list: widget.cubit!.waiting,
                                  ));
                          }
                        },
                        child: Indicator(
                          count: '${widget.wcount}',
                          color: Colors.red,
                          text: LocaleKeys.waiting.tr(),
                          isSquare: false,
                          size: touchedIndex == 0 ? 25 : 16,
                          textColor: touchedIndex == 0
                              ? Colors.red
                              : Colors.red.shade500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (uIdA == 'AntiCyberCrimesUnit') {
                            if (widget.cubitCrimes!.prosses.isNotEmpty)
                              navigateTo(
                                  context,
                                  ViewFilterCyber(
                                    title: LocaleKeys.Prosses.tr(),
                                    cyberCrimes: widget.cubitCrimes,
                                    list: widget.cubitCrimes!.prosses,
                                  ));
                          } else if (uIdA == 'MinistryofCommunications') {
                            if (widget.cubitComm!.prosses.isNotEmpty)
                              navigateTo(
                                  context,
                                  ViewFilterComm(
                                    title: LocaleKeys.Prosses.tr(),
                                    commCubit: widget.cubitComm,
                                    list: widget.cubitComm!.prosses,
                                  ));
                          } else {
                            if (widget.cubit!.prosses.isNotEmpty)
                              navigateTo(
                                  context,
                                  ViewFilter(
                                    title: LocaleKeys.Prosses.tr(),
                                    cubit: widget.cubit,
                                    list: widget.cubit!.prosses,
                                  ));
                          }
                        },
                        child: Indicator(
                          count: '${widget.pcount}',
                          color: Colors.amber,
                          text: LocaleKeys.Prosses.tr(),
                          isSquare: false,
                          size: touchedIndex == 1 ? 25 : 16,
                          textColor: touchedIndex == 1
                              ? Colors.amber
                              : Colors.amber.shade500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (uIdA == 'AntiCyberCrimesUnit') {
                            if (widget.cubitCrimes!.success.isNotEmpty)
                              navigateTo(
                                  context,
                                  ViewFilterCyber(
                                    title: LocaleKeys.Success.tr(),
                                    cyberCrimes: widget.cubitCrimes,
                                    list: widget.cubitCrimes!.success,
                                  ));
                          } else if (uIdA == 'MinistryofCommunications') {
                            if (widget.cubitComm!.success.isNotEmpty)
                              navigateTo(
                                  context,
                                  ViewFilterComm(
                                    title: LocaleKeys.Success.tr(),
                                    commCubit: widget.cubitComm,
                                    list: widget.cubitComm!.success,
                                  ));
                          } else {
                            if (widget.cubit!.success.isNotEmpty)
                              navigateTo(
                                  context,
                                  ViewFilter(
                                    title: LocaleKeys.Success.tr(),
                                    cubit: widget.cubit,
                                    list: widget.cubit!.success,
                                  ));
                          }
                        },
                        child: Indicator(
                          count: '${widget.scount}',
                          color: ColorManager.primary,
                          text: LocaleKeys.Success.tr(),
                          isSquare: false,
                          size: touchedIndex == 2 ? 25 : 16,
                          textColor: touchedIndex == 2
                              ? Colors.green
                              : Colors.green.shade500,
                        ),
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
