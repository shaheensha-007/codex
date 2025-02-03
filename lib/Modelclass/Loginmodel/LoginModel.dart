class LoginModel {
  LoginModel({
      this.id, 
      this.token, 
      this.message, 
      this.status,
      this.details,
  });

  LoginModel.fromJson(dynamic json) {
    id = json['id'];
    token = json['token'];
    message = json['message'];
    status = json['status'];
    details=json['detail'];
  }
  int? id;
  String? token;
  String? message;
  bool? status;
  String? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['token'] = token;
    map['message'] = message;
    map['status'] = status;
    map['detail']=details;
    return map;
  }

}