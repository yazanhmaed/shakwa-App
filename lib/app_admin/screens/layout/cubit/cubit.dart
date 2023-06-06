import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_test/app_admin/screens/layout/cubit/states.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../models/add_communications_model.dart';
import '../../../models/cyber_crimes_model.dart';
import '../../../models/event.dart';

class LayoutCubit extends Cubit<ComplaintsStates> {
  LayoutCubit() : super(ComplaintsInitialState());
  static LayoutCubit get(context) => BlocProvider.of(context);
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
  List<String> dataName = [
    'AntiCyberCrimesUnit',
    'AmmanCity',
    'ElectricPower',
    'MinistryOfAgriculture',
    'MinistryofCommunications',
    'MinistryofEnvironment',
    'Miyahuna',
    'TrafficDepartment',
  ];

  var antiCyberCrimesUnit = 0;
  var ammanCity = 0;
  var electricPower = 0;
  var ministryOfAgriculture = 0;
  var ministryofCommunications = 0;
  var ministryofEnvironment = 0;
  var miyahuna = 0;
  var trafficDepartment = 0;

  ///
  var antiCyberRate = 0.0;
  var ammanRate = 0.0;
  var electricPowerRate = 0.0;
  var rateAgriculture = 0.0;
  var rateCommunications = 0.0;
  var rateEnvironment = 0.0;
  var miyahunaRate = 0.0;
  var trafficDepartmentRate = 0.0;

  ///
  List<CyberCrimesModel> antiCyberModel = [];
  List<ComplaintsModel> ammanCityModel = [];
  List<ComplaintsModel> electricPowerModel = [];
  List<ComplaintsModel> ofAgricultureModel = [];
  List<CommunicationsModel> ofCommunicationsModel = [];
  List<ComplaintsModel> ofEnvironmentModel = [];
  List<ComplaintsModel> miyahunaModel = [];
  List<ComplaintsModel> trafficDepartmentModel = [];

  Future getAmmanCity() async {
    var s1 = 0;
    var s2 = 0;
    var s3 = 0;
    var s4 = 0;
    var s5 = 0;

    emit(ComplaintsLoadingState());
    await FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc('AmmanCity')
        .collection('complaint')
        .get()
        .then((value) {
      ammanCity = value.docs.length;
      for (var e in value.docs) {
        ammanCityModel.add(ComplaintsModel.fromJson(e.data()));
      }
      for (var element in ammanCityModel) {
        if (element.rating != null && element.rating! == 1) {
          s1 = s1 + 1;
        } else if (element.rating != null && element.rating! == 2) {
          s2 = s2 + 1;
        } else if (element.rating != null && element.rating! == 3) {
          s3 = s3 + 1;
        } else if (element.rating != null && element.rating! == 4) {
          s4 = s4 + 1;
        } else if (element.rating != null && element.rating! == 5) {
          s5 = s5 + 1;
        }
      }
      var r = (s5 * 5) + (s4 * 4) + (s3 * 3) + (s2 * 2) + (s1 * 1);

      if (s1 != 0 || s2 != 0 || s3 != 0 || s4 != 0 || s5 != 0) {
        ammanRate = r / (s5 + s4 + s3 + s2 + s1);
      }

      emit(AmmanCitySuccessState());
    }).catchError((onError) {
      print(onError);
    });
  }

  Future getAntiCyberCrimesUnit() async {
    var s1 = 0;
    var s2 = 0;
    var s3 = 0;
    var s4 = 0;
    var s5 = 0;
    emit(ComplaintsLoadingState());
    await FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc('AntiCyberCrimesUnit')
        .collection('complaint')
        .get()
        .then((value) {
      antiCyberCrimesUnit = value.docs.length;
      for (var e in value.docs) {
        antiCyberModel.add(CyberCrimesModel.fromJson(e.data()));
      }
      for (var element in antiCyberModel) {
        if (element.rating != null && element.rating! == 1) {
          s1 = s1 + 1;
        } else if (element.rating != null && element.rating! == 2) {
          s2 = s2 + 1;
        } else if (element.rating != null && element.rating! == 3) {
          s3 = s3 + 1;
        } else if (element.rating != null && element.rating! == 4) {
          s4 = s4 + 1;
        } else if (element.rating != null && element.rating! == 5) {
          s5 = s5 + 1;
        }
      }
      var r = (s5 * 5) + (s4 * 4) + (s3 * 3) + (s2 * 2) + (s1 * 1);

      if (s1 != 0 || s2 != 0 || s3 != 0 || s4 != 0 || s5 != 0) {
        antiCyberRate = r / (s5 + s4 + s3 + s2 + s1);
      }

      emit(AntiCyberCrimesUnitSuccessState());
    }).catchError((onError) {
      print(onError);
    });
  }

  Future getElectricPower() async {
    var s1 = 0;
    var s2 = 0;
    var s3 = 0;
    var s4 = 0;
    var s5 = 0;
    emit(ComplaintsLoadingState());
    await FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc('ElectricPower')
        .collection('complaint')
        .get()
        .then((value) {
      electricPower = value.docs.length;
      for (var e in value.docs) {
        electricPowerModel.add(ComplaintsModel.fromJson(e.data()));
      }
      for (var element in electricPowerModel) {
        if (element.rating != null && element.rating! == 1) {
          s1 = s1 + 1;
        } else if (element.rating != null && element.rating! == 2) {
          s2 = s2 + 1;
        } else if (element.rating != null && element.rating! == 3) {
          s3 = s3 + 1;
        } else if (element.rating != null && element.rating! == 4) {
          s4 = s4 + 1;
        } else if (element.rating != null && element.rating! == 5) {
          s5 = s5 + 1;
        }
      }
      var r = (s5 * 5) + (s4 * 4) + (s3 * 3) + (s2 * 2) + (s1 * 1);

      if (s1 != 0 || s2 != 0 || s3 != 0 || s4 != 0 || s5 != 0) {
        electricPowerRate = r / (s5 + s4 + s3 + s2 + s1);
      }

      emit(ElectricPowerSuccessState());
    }).catchError((onError) {
      print(onError);
    });
  }

  Future getMinistryOfAgriculture() async {
    var s1 = 0;
    var s2 = 0;
    var s3 = 0;
    var s4 = 0;
    var s5 = 0;
    emit(ComplaintsLoadingState());
    await FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc('MinistryOfAgriculture')
        .collection('complaint')
        .get()
        .then((value) {
      ministryOfAgriculture = value.docs.length;
      for (var e in value.docs) {
        ofAgricultureModel.add(ComplaintsModel.fromJson(e.data()));
      }
      for (var element in ofAgricultureModel) {
        if (element.rating != null && element.rating! == 1) {
          s1 = s1 + 1;
        } else if (element.rating != null && element.rating! == 2) {
          s2 = s2 + 1;
        } else if (element.rating != null && element.rating! == 3) {
          s3 = s3 + 1;
        } else if (element.rating != null && element.rating! == 4) {
          s4 = s4 + 1;
        } else if (element.rating != null && element.rating! == 5) {
          s5 = s5 + 1;
        }
      }
      var r = (s5 * 5) + (s4 * 4) + (s3 * 3) + (s2 * 2) + (s1 * 1);

      if (s1 != 0 || s2 != 0 || s3 != 0 || s4 != 0 || s5 != 0) {
        rateAgriculture = r / (s5 + s4 + s3 + s2 + s1);
      }

      emit(MinistryOfAgricultureSuccessState());
    }).catchError((onError) {
      print(onError);
    });
  }

  Future getMinistryofCommunications() async {
    var s1 = 0;
    var s2 = 0;
    var s3 = 0;
    var s4 = 0;
    var s5 = 0;
    emit(ComplaintsLoadingState());
    await FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc('MinistryofCommunications')
        .collection('complaint')
        .get()
        .then((value) {
      ministryofCommunications = value.docs.length;
      for (var e in value.docs) {
        ofCommunicationsModel.add(CommunicationsModel.fromJson(e.data()));
      }
      for (var element in ofCommunicationsModel) {
        if (element.rating != null && element.rating! == 1) {
          s1 = s1 + 1;
        } else if (element.rating != null && element.rating! == 2) {
          s2 = s2 + 1;
        } else if (element.rating != null && element.rating! == 3) {
          s3 = s3 + 1;
        } else if (element.rating != null && element.rating! == 4) {
          s4 = s4 + 1;
        } else if (element.rating != null && element.rating! == 5) {
          s5 = s5 + 1;
        }
      }
      var r = (s5 * 5) + (s4 * 4) + (s3 * 3) + (s2 * 2) + (s1 * 1);

      if (s1 != 0 || s2 != 0 || s3 != 0 || s4 != 0 || s5 != 0) {
        rateCommunications = r / (s5 + s4 + s3 + s2 + s1);
      }
      emit(MinistryofCommunicationsSuccessState());
    }).catchError((onError) {
      print(onError);
    });
  }

  Future getMinistryofEnvironment() async {
    var s1 = 0;
    var s2 = 0;
    var s3 = 0;
    var s4 = 0;
    var s5 = 0;
    emit(ComplaintsLoadingState());
    await FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc('MinistryofEnvironment')
        .collection('complaint')
        .get()
        .then((value) {
      ministryofEnvironment = value.docs.length;
      for (var e in value.docs) {
        ofEnvironmentModel.add(ComplaintsModel.fromJson(e.data()));
      }
      for (var element in ofEnvironmentModel) {
        if (element.rating != null && element.rating! == 1) {
          s1 = s1 + 1;
        } else if (element.rating != null && element.rating! == 2) {
          s2 = s2 + 1;
        } else if (element.rating != null && element.rating! == 3) {
          s3 = s3 + 1;
        } else if (element.rating != null && element.rating! == 4) {
          s4 = s4 + 1;
        } else if (element.rating != null && element.rating! == 5) {
          s5 = s5 + 1;
        }
      }
      var r = (s5 * 5) + (s4 * 4) + (s3 * 3) + (s2 * 2) + (s1 * 1);

      if (s1 != 0 || s2 != 0 || s3 != 0 || s4 != 0 || s5 != 0) {
        rateEnvironment = r / (s5 + s4 + s3 + s2 + s1);
      }

      emit(MinistryofEnvironmentSuccessState());
    }).catchError((onError) {
      print(onError);
    });
  }

  Future getMiyahuna() async {
    var s1 = 0;
    var s2 = 0;
    var s3 = 0;
    var s4 = 0;
    var s5 = 0;
    emit(ComplaintsLoadingState());
    await FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc('Miyahuna')
        .collection('complaint')
        .get()
        .then((value) {
      miyahuna = value.docs.length;
      for (var e in value.docs) {
        miyahunaModel.add(ComplaintsModel.fromJson(e.data()));
      }
      for (var element in miyahunaModel) {
        if (element.rating != null && element.rating! == 1) {
          s1 = s1 + 1;
        } else if (element.rating != null && element.rating! == 2) {
          s2 = s2 + 1;
        } else if (element.rating != null && element.rating! == 3) {
          s3 = s3 + 1;
        } else if (element.rating != null && element.rating! == 4) {
          s4 = s4 + 1;
        } else if (element.rating != null && element.rating! == 5) {
          s5 = s5 + 1;
        }
      }
      var r = (s5 * 5) + (s4 * 4) + (s3 * 3) + (s2 * 2) + (s1 * 1);

      if (s1 != 0 || s2 != 0 || s3 != 0 || s4 != 0 || s5 != 0) {
        miyahunaRate = r / (s5 + s4 + s3 + s2 + s1);
      }

      emit(MiyahunaSuccessState());
    }).catchError((onError) {
      print(onError);
    });
  }

  Future getTrafficDepartment() async {
    var s1 = 0;
    var s2 = 0;
    var s3 = 0;
    var s4 = 0;
    var s5 = 0;
    emit(ComplaintsLoadingState());
    await FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc('TrafficDepartment')
        .collection('complaint')
        .get()
        .then((value) {
      trafficDepartment = value.docs.length;
      for (var e in value.docs) {
        trafficDepartmentModel.add(ComplaintsModel.fromJson(e.data()));
      }
      for (var element in trafficDepartmentModel) {
        if (element.rating != null && element.rating! == 1) {
          s1 = s1 + 1;
        } else if (element.rating != null && element.rating! == 2) {
          s2 = s2 + 1;
        } else if (element.rating != null && element.rating! == 3) {
          s3 = s3 + 1;
        } else if (element.rating != null && element.rating! == 4) {
          s4 = s4 + 1;
        } else if (element.rating != null && element.rating! == 5) {
          s5 = s5 + 1;
        }
      }
      var r = (s5 * 5) + (s4 * 4) + (s3 * 3) + (s2 * 2) + (s1 * 1);

      if (s1 != 0 || s2 != 0 || s3 != 0 || s4 != 0 || s5 != 0) {
        trafficDepartmentRate = r / (s5 + s4 + s3 + s2 + s1);
      }
      emit(TrafficDepartmentSuccessState());
    }).catchError((onError) {
      print(onError);
    });
  }
}
