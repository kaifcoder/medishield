class UserModel {
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? mobile;
  bool? isEmailVerified;
  String? googleAuthToken;

  UserModel(
      {this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.mobile,
      this.isEmailVerified,
      this.googleAuthToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    firstName = json['firstname'] ?? '';
    lastName = json['lastname'] ?? '';
    mobile = json['mobile'] ?? '';
    isEmailVerified = json['isEmailVerified'] ?? false;
    googleAuthToken = json['googleAuthToken'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
    data['firstname'] = firstName;
    data['lastname'] = lastName;
    data['mobile'] = mobile;
    data['isEmailVerified'] = isEmailVerified ?? false;
    data['googleAuthToken'] = googleAuthToken ?? '';
    return data;
  }
}
