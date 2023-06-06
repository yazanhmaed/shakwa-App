import 'package:cloud_firestore/cloud_firestore.dart';

class AddComplaintModel {
  String? id;
  String? id2;
  String? type;
  String? description;
  String? competent;
  String? image;
  String? latitude;
  String? longitude;
  String? state;
  String? token;
  String? note;
  int? color;
  int? rating;
  Timestamp? date;
  Timestamp? timeSpent;
  AddComplaintModel({
    this.id,
    this.id2,
    this.type,
    this.description,
    this.competent,
    this.image,
    this.latitude,
    this.longitude,
    this.state,
    this.token,
    this.note,
    this.color,
    this.rating,
    this.date,
    this.timeSpent,
  });

  AddComplaintModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id2 = json['id2'];
    type = json['type'];
    description = json['description'];
    competent = json['competent'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    state = json['state'];
    token = json['token'];
    note = json['note'];
    color = json['color'];
    rating = json['rating'];
    date = json['date'];
    timeSpent = json['timeSpent'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id2': id2,
      'type': type,
      'description': description,
      'image': image,
      'competent': competent,
      'latitude': latitude,
      'longitude': longitude,
      'state': state,
      'token': token,
      'note': note,
      'color': color,
      'rating': rating,
      'date': date,
      'timeSpent': timeSpent,
    };
  }
}
