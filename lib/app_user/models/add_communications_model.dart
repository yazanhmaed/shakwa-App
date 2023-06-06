import 'package:cloud_firestore/cloud_firestore.dart';

class AddCommunicationsModel {
  String? id;
  String? id2;
  String? competent;
  String? type;
  String? social;
  String? description;
  String? image;
  String? state;
  String? token;
  String? note;
  int? color;
  int? rating;
  Timestamp? date;
  Timestamp? timeSpent;
  AddCommunicationsModel({
    this.id,
    this.id2,
    this.type,
    this.social,
    this.competent,
    this.description,
    this.image,
    this.state,
    this.token,
    this.note,
    this.color,
    this.rating,
    this.date,
    this.timeSpent,
  });

  AddCommunicationsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id2 = json['id2'];
    type = json['type'];
    social = json['social'];
    description = json['description'];
    image = json['image'];
    competent = json['competent'];

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
      'social': social,
      'competent': competent,
      'description': description,
      'image': image,
      'state': state,
      'token': token,
      'color': color,
      'note': note,
      'rating': rating,
      'date': date,
      'timeSpent': timeSpent,
    };
  }
}
