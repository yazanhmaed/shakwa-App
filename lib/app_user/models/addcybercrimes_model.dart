import 'package:cloud_firestore/cloud_firestore.dart';

class AddCyberCrimesModel {
  String? id;
  String? id2;
  String? type;
  String? social;
  String? description;
  String? competent;
  String? image;
  String? link;
  String? state;
  String? token;
  String? note;
  int? color;
  int? rating;
  Timestamp? date;
  Timestamp? timeSpent;
  AddCyberCrimesModel({
    this.id,
    this.id2,
    this.type,
    this.social,
    this.description,
    this.competent,
    this.image,
    this.link,
    this.state,
    this.note,
    this.token,
    this.color,
    this.rating,
    this.date,
    this.timeSpent,
  });

  AddCyberCrimesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id2 = json['id2'];
    type = json['type'];
    social = json['social'];
    description = json['description'];
    competent = json['competent'];
    image = json['image'];
    link = json['link'];
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
      'description': description,
      'image': image,
      'competent': competent,
      'link': link,
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
