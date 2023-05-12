class AddComplaintModel {
  String? id;
  String? type;
  String? doc;
  String? image;
  String? latitude;
  String? longitude;
  String? state;
  String? token;
  AddComplaintModel({
    this.id,
    this.type,
    this.doc,
    this.image,
    this.latitude,
    this.longitude,
    this.state,
    this.token,
  });

  AddComplaintModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    doc = json['doc'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    state = json['state'];
    token = json['token'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'doc': doc,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
      'state': state,
      'token': token,
    };
  }
}
