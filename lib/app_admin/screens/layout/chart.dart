import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_test/app_admin/screens/layout/cubit/states.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../translations/locale_keys.g.dart';
import 'chart_view.dart';
import 'cubit/cubit.dart';

class ChartView extends StatelessWidget {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()
        ..getAmmanCity()
        ..getAntiCyberCrimesUnit()
        ..getElectricPower()
        ..getMinistryOfAgriculture()
        ..getMinistryofCommunications()
        ..getMinistryofEnvironment()
        ..getMiyahuna()
        ..getTrafficDepartment(),
      child: BlocConsumer<LayoutCubit, ComplaintsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
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
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      LocaleKeys.complaints.tr(),
                      style: TextStyle(
                          color: ColorManager.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorManager.primary,
                    ),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        RevChart(
                            mess: '${cubit.antiCyberCrimesUnit}',
                            label: cubit.name[0],
                            pct: cubit.antiCyberCrimesUnit,
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.ammanCity}',
                            label: cubit.name[1],
                            pct: cubit.ammanCity,
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.electricPower}',
                            label: cubit.name[2],
                            pct: cubit.electricPower,
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.ministryOfAgriculture}',
                            label: cubit.name[3],
                            pct: cubit.ministryOfAgriculture,
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.ministryofCommunications}',
                            label: cubit.name[4],
                            pct: cubit.ministryofCommunications,
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.ministryofEnvironment}',
                            label: cubit.name[5],
                            pct: cubit.ministryofEnvironment,
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.miyahuna}',
                            label: cubit.name[6],
                            pct: cubit.miyahuna,
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.trafficDepartment}',
                            label: cubit.name[7],
                            pct: cubit.trafficDepartment,
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      LocaleKeys.Rate.tr(),
                      style: TextStyle(
                          color: ColorManager.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorManager.primary,
                    ),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        RevChart(
                            mess: '${cubit.antiCyberRate}',
                            label: cubit.name[0],
                            pct: cubit.antiCyberRate.toInt(),
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.ammanRate}',
                            label: cubit.name[1],
                            pct: cubit.ammanRate.toInt(),
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.electricPowerRate}',
                            label: cubit.name[2],
                            pct: cubit.electricPowerRate.toInt(),
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.rateAgriculture}',
                            label: cubit.name[3],
                            pct: cubit.rateAgriculture.toInt(),
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.rateCommunications}',
                            label: cubit.name[4],
                            pct: cubit.rateCommunications.toInt(),
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.rateEnvironment}',
                            label: cubit.name[5],
                            pct: cubit.rateEnvironment.toInt(),
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.miyahunaRate}',
                            label: cubit.name[6],
                            pct: cubit.miyahunaRate.toInt(),
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                        RevChart(
                            mess: '${cubit.trafficDepartmentRate}',
                            label: cubit.name[7],
                            pct: cubit.trafficDepartmentRate.toInt(),
                            iconData: Icons.sentiment_dissatisfied),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
