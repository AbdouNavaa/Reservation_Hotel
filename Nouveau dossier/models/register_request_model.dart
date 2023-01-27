class RegisterRequestModel {
  RegisterRequestModel({required this.username, required this.password, required String email});
  late final String username;
  late final String password;
  late final String email;
  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final  _data = <String, dynamic>{};
    _data['username'] = this.username;
    _data['password'] = this.password;
    _data['email'] = this.email;
    return _data;
  }
}
