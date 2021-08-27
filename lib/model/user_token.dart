class TokenNoti{
  bool? status;
  String? device_id;
  TokenNoti.fromJson(Map<String, dynamic>json){
    status = json['status'];
    device_id = json['device_id'];
  }
}