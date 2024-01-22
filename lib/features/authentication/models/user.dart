class User {
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? mobile;

  User({this.email, this.password, this.firstName, this.lastName, this.mobile});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    firstName = json['firstname'] ?? '';
    lastName = json['lastname'] ?? '';
    mobile = json['mobile'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
    data['firstname'] = firstName;
    data['lastname'] = lastName;
    data['mobile'] = mobile;
    return data;
  }
}
