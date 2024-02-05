class AddressModel {
  String? id;
  String? name;
  String? address;
  String? city;
  String? state;
  String? mobile;
  String? pincode;
  String? country;

  AddressModel({
    this.id,
    this.name,
    this.address,
    this.city,
    this.state,
    this.mobile,
    this.pincode,
    this.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      mobile: json['mobile'] ?? '',
      pincode: json['pincode'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['mobile'] = mobile;
    data['pincode'] = pincode;
    data['country'] = country;
    return data;
  }
}
