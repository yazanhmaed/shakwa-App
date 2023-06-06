import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_test/app_user/screens/follow_complaints/cubit/states.dart';


import '../../../../resources/components.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../models/add_complaint_model.dart';
import '../../../models/user_model.dart';

class FollowComplaintsCubit extends Cubit<FollowComplaintsStates> {
  FollowComplaintsCubit() : super(FollowComplaintsInitialState());

  static FollowComplaintsCubit get(context) => BlocProvider.of(context);

  List<AddComplaintModel> followComplaints = [];
  List<AddComplaintModel> prossesComplaints = [];
  List<AddComplaintModel> completeComplaints = [];

  int? rate;

    TextEditingController noteController = TextEditingController();

  Future getFollowComplaints() async {
    followComplaints = [];
    emit(FollowComplaintsLoadingState());
    await FirebaseFirestore.instance
        .collection('Users/')
        .doc(uId)
        .collection('complaint')
        .get()
        .then((value) {
      for (var e in value.docs) {
        followComplaints.add(AddComplaintModel.fromJson(e.data()));
      }
      followComplaints.forEach((element) {
        if (element.state == 'Success') {
          completeComplaints.add(element);
        } else {
          prossesComplaints.add(element);
        }
      });

      emit(FollowComplaintsSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(FollowComplaintsErrorState());
    });
  }

  void updateRating({
    required int rating,
    required String id2,
    required String id,
    required String note,
  }) {
    FirebaseFirestore.instance
        .collection('competentAuthority')
        .doc(id)
        .collection('complaint')
        .doc(id2)
        .update({
      'rating': rating,
      'note': note,
    }).then((value) {
      emit(ComplaintsUpdateSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(ComplaintsUpdateErrorState());
    }).then((value) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .collection('complaint')
          .doc(id2)
          .update({
        'rating': rating,
        'note': note,
      });
    }).catchError((onError){
      print(onError);
      emit(ComplaintsUpdateErrorState());
    });
  }

  void removeComplaint({
    required String id2,
  }) {
    FirebaseFirestore.instance
        .collection('Users/')
        .doc(uId)
        .collection('complaint')
        .doc(id2)
        .delete()
        .then((value) {
      getFollowComplaints();
      emit(FollowRemoveSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(FollowRemoveErrorState());
    });
  }

  List<UserModel> users = [];

  void getUser() async {
    users = [];
    emit(GetUserLoadingState());
    await FirebaseFirestore.instance
        .collection('Users/')
        .doc('$uId')
        .collection('profile')
        .get()
        .then((value) {
      for (var e in value.docs) {
        users.add(UserModel.fromJson(e.data()));
      }
      nameUser = users[0].name!;

      emit(GetUserSuccessState(users[0].name!));
    }).catchError((onError) {
      print(onError);
      emit(GetUserErrorState());
    });
  }

  List name = [
    LocaleKeys.Anti_Cyber_Crimes.tr(),
    LocaleKeys.Amman_City.tr(),
    LocaleKeys.Electric_Power.tr(),
    LocaleKeys.Agriculture.tr(),
    LocaleKeys.Communications.tr(),
    LocaleKeys.Environment.tr(),
    LocaleKeys.Miyahuna.tr(),
    LocaleKeys.Traffic_Department.tr(),
  ];

  List<String> cyberName = [
    LocaleKeys.Facebook.tr(),
    LocaleKeys.Instagram.tr(),
    LocaleKeys.Web.tr(),
    LocaleKeys.Ad.tr(),
    LocaleKeys.other.tr(),
  ];
  List<String> communications = [
    LocaleKeys.zain.tr(),
    LocaleKeys.Orange.tr(),
    LocaleKeys.Umniah.tr(),
  ];
  List complaints = [
    {
      'AntiCyberCrimesUnit': [
        LocaleKeys.Hacking_personal_accounts.tr(),
        LocaleKeys.Electronic_harassment.tr(),
        LocaleKeys.privacy_personal_data.tr(),
        LocaleKeys.Fraud_in_online_purchases.tr(),
        LocaleKeys.Assault_and_defamation.tr(),
        LocaleKeys.Impersonation_pseudonyms.tr(),
        LocaleKeys.other.tr(),
      ],
      'AmmanCity': [
        LocaleKeys.hole_in_the_street.tr(),
        LocaleKeys.Pavement_problems.tr(),
        LocaleKeys.illegal_construction.tr(),
        LocaleKeys.Unlicensed_stores.tr(),
        LocaleKeys.Demolition_and_construction.tr(),
        LocaleKeys.Scattered_waste.tr(),
        LocaleKeys.other.tr(),
      ],
      'ElectricPower': [
        LocaleKeys.Electricity_theft.tr(),
        LocaleKeys.street_lighting.tr(),
        LocaleKeys.Electricity_poles.tr(),
        LocaleKeys.electricity_network.tr(),
        LocaleKeys.Frequent_power_outages.tr(),
        LocaleKeys.High_electricity_bills.tr(),
        LocaleKeys.other.tr(),
      ],
      'MinistryOfAgriculture': [
        LocaleKeys.Water_and_soil_pollution.tr(),
        LocaleKeys.harmful_pesticides.tr(),
        LocaleKeys.Difficulty_accessing_markets.tr(),
        LocaleKeys.health_and_quality.tr(),
        LocaleKeys.other.tr(),
      ],
      'MinistryofCommunications': [
        LocaleKeys.Service_quality_affected.tr(),
        LocaleKeys.High_prices_for_services.tr(),
        LocaleKeys.Poor_network_coverage.tr(),
        LocaleKeys.customer_service.tr(),
        LocaleKeys.other.tr(),
      ],
      'MinistryofEnvironment': [
        LocaleKeys.blocking_trees.tr(),
        LocaleKeys.pollution_from_vehicles.tr(),
        LocaleKeys.resulting_from_factories.tr(),
        LocaleKeys.cut_down_trees.tr(),
        LocaleKeys.other.tr(),
      ],
      'Miyahuna': [
        LocaleKeys.Broken_water_pipe.tr(),
        LocaleKeys.presence_of_sewage.tr(),
        LocaleKeys.Frequent_water_outages.tr(),
        LocaleKeys.High_water_bills.tr(),
        LocaleKeys.other.tr(),
      ],
      'TrafficDepartment': [
        LocaleKeys.Car_accident.tr(),
        LocaleKeys.damaged_cars.tr(),
        LocaleKeys.Traffic_signal_malfunction.tr(),
        LocaleKeys.Objection_traffic_violation.tr(),
        LocaleKeys.other.tr(),
      ],
    },
  ];
}
