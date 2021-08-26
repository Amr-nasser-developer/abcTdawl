class Login{
  bool? status;
  User? user;
  String? ERRORS;

  Login.fromJson(Map<String, dynamic> json)
  {
    ERRORS= json['ERRORS'];
    status = json['STATUS'];
    user = json['USER'] != null ? User.fromJson(json['USER']) : null;
  }
}
class ERRORS{}
class User{
  String? name;
  String? phone;
  String? password;
  String? email;
  var id;
  String? token;
  User.fromJson(Map<String, dynamic> json){
    token = json['token'];
    name = json['name'];
    phone = json['phone'];
    id = json['id'];
    password = json['password'];
    email = json['email'];
  }
}