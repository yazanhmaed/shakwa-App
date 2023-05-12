class UserModel {
  String? uId;
  String? name;
  String? email;
  String? token;
  

  UserModel({
    this.uId,
    this.name,
    this.email,
    this.token,
  
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'token': token,
     
    };
  }
}
