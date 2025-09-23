class LoginRequestModel {
  int?  tax_code;
  String? user_name;
  String? password;

  LoginRequestModel({this.tax_code, this.user_name, this.password});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      tax_code:json['tax_code'],
      user_name: json['user_name'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toJson() => {
        "tax_code": tax_code,
        "user_name": user_name,
        "password": password,
      };
}