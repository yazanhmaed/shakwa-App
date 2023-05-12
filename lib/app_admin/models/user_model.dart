class UserModel {
  String? uId;
  String? name;
  String? email;
  

  UserModel({
    this.uId,
    this.name,
    this.email,
  
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
     
    };
  }
}
