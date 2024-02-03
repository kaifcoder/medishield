
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

  String get fullName => '$firstName $lastName';

  String get formattedMobile => '+91 $mobile';

  static UserModel empty() {
    return UserModel(
      email: '',
      password: '',
      firstName: '',
      lastName: '',
      mobile: '',
      isEmailVerified: null,
      googleAuthToken: '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return UserModel.empty();
    }
    return UserModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      firstName: json['firstname'] ?? '',
      lastName: json['lastname'] ?? '',
      mobile: json['mobile'] ?? '',
      isEmailVerified: json['isEmailVerified'] ?? false,
      googleAuthToken: json['googleAuthToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
