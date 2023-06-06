import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_test/app_admin/screens/pie/cubit/states.dart';

import '../../../../resources/components.dart';
import '../../../models/event.dart';


class ChartCubit extends Cubit<ChartStates> {
  ChartCubit() : super(ChartInitialState());

  static ChartCubit get(context) => BlocProvider.of(context);

  List<ComplaintsModel> chartModel = [];

  var jan = 0;
  var feb = 0;
  var mar = 0;
  var apr = 0;
  var may = 0;
  var jun = 0;
  var jul = 0;
  var aug = 0;
  var sept = 0;
  var oct = 0;
  var nov = 0;
  var dec = 0;
  Future getChart() async {
    chartModel = [];
    jan = 0;
    feb = 0;
    mar = 0;
    apr = 0;
    may = 0;
    jun = 0;
    jul = 0;
    aug = 0;
    sept = 0;
    oct = 0;
    nov = 0;
    dec = 0;
    emit(ChartLoadingState());
    await FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc(uIdA)
        .collection('complaint')
        .get()
        .then((value) {
      for (var e in value.docs) {
        chartModel.add(ComplaintsModel.fromJson(e.data()));
      }
      for (var element in chartModel) {
        if (element.date!.toDate().month == 1) {
          jan++;
        }
        if (element.date!.toDate().month == 2) {
          feb++;
        }
        if (element.date!.toDate().month == 3) {
          mar++;
        }
        if (element.date!.toDate().month == 4) {
          apr++;
        }
        if (element.date!.toDate().month == 5) {
          may++;
        }
        if (element.date!.toDate().month == 6) {
          jun++;
        }
        if (element.date!.toDate().month == 7) {
          jul++;
        }
        if (element.date!.toDate().month == 8) {
          aug++;
        }
        if (element.date!.toDate().month == 9) {
          sept++;
        }
        if (element.date!.toDate().month == 10) {
          oct++;
        }
        if (element.date!.toDate().month == 11) {
          nov++;
        }
        if (element.date!.toDate().month == 12) {
          dec++;
        }
      }

      emit(ChartSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(ChartErrorState());
    });
  }
}
