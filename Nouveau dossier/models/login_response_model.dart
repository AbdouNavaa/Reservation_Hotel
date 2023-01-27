import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));
class LoginResponseModel {
  LoginResponseModel({required this.message, required this.data});
  late final String message;
  late final Data data;
  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = this.message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  // String token;

  Data({required this.username, required this.email, required this.date, required this.id});
  late final String username;
  late final String email;
  late final String date;
  late final String id;

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = this.username;
    _data['email'] = this.email;
    _data['date'] = this.date;
    _data['id'] = this.id;
    return _data;
  }
}
