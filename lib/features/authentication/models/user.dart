class UserModel {
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? mobile;
  bool? isEmailVerified;
  String? googleAuthToken;
  String? referralCode;
  final int? medishieldcoins;

  UserModel(
      {this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.mobile,
      this.isEmailVerified,
      this.googleAuthToken,
      this.referralCode,
      this.medishieldcoins});

  String get fullName => '$firstName $lastName';

  String get formattedMobile => '$mobile';

  static UserModel empty() {
    return UserModel(
        email: '',
        password: '',
        firstName: '',
        lastName: '',
        mobile: '',
        isEmailVerified: null,
        googleAuthToken: '',
        referralCode: '');
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
      referralCode: json['referralCode'] ?? '',
      medishieldcoins: json['medishieldcoins'] ?? 0,
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
    data['googleAuthToken'] = googleAuthToken;
    data['referralCode'] = referralCode;
    return data;
  }
}
