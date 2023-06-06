import 'package:cloud_firestore/cloud_firestore.dart';

class CyberCrimesModel {
  String? id;
  String? id2;
  String? type;
  String? social;
  String? description;
  String? image;
  String? link;
  String? state;
  String? token;
  String? note;
  int? color;
  int? rating;
  Timestamp? date;
  Timestamp? timeSpent;
  CyberCrimesModel({
    this.id,
    this.id2,
    this.type,
    this.social,
    this.description,
    this.image,
    this.link,
    this.state,
    this.token,
    this.note,
    this.color,
    this.rating,
    this.date,
    this.timeSpent,
  });

  CyberCrimesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id2 = json['id2'];
    type = json['type'];
    social = json['social'];
    description = json['description'];
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
