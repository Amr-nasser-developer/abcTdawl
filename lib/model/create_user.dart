class Register{
  var status;
 User? user;

  Register.fromJson(Map<String, dynamic> json)
 {
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
  User.fromJson(Map<String, dynamic> json){
    name = json['name'];
    phone = json['phone'];
    id = json['id'];
    password = json['password'];
    email = json['email'];
  }
}