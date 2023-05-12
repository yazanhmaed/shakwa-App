import 'package:cloud_firestore/cloud_firestore.dart';

class AddComplaintModel {
  String? id;
  String? id2;
  String? type;
  String? description;
  String? image;
  String? latitude;
  String? longitude;
  String? state;
  String? token;
  int? color;
  Timestamp? date;
  AddComplaintModel({
    this.id,
    this.id2,
    this.type,
    this.description,
    this.image,
    this.latitude,
    this.longitude,
    this.state,
    this.token,
    this.color,
    this.date,
  });

  AddComplaintModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id2 = json['id2'];
    type = json['type'];
    description = json['description'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    state = json['state'];
    token = json['token'];
    color = json['color'];
    date = json['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id2': id2,
      'type': type,
      'description': description,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
      'state': state,
      'token': token,
      'color': color,
      'date': date,
    };
  }
}
