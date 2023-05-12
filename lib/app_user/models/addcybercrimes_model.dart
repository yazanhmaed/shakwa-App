import 'package:cloud_firestore/cloud_firestore.dart';

class AddCyberCrimesModel {
  String? id;
  String? id2;
  String? type;
  String? social;
  String? description;
  String? image;
  String? link;
  String? state;
  String? token;
  int? color;
  Timestamp? date;
  AddCyberCrimesModel({
    this.id,
    this.id2,
    this.type,
    this.social,
    this.description,
    this.image,
    this.link,
    this.state,
    this.token,
    this.color,
    this.date,
  });

  AddCyberCrimesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id2 = json['id2'];
    type = json['type'];
    social = json['social'];
    description = json['description'];
    image = json['image'];
    link = json['link'];
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
      'social': social,
      'description': description,
      'image': image,
      'link': link,
      'state': state,
      'token': token,
      'color': color,
      'date': date,
    };
  }
}
