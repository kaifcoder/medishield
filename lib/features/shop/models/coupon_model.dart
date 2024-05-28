class Coupon {
  String? sId;
  String? couponCode;
  int? discount;
  String? type;
  int? minimumCartValue;
  int? minimumMedishieldCoins;
  String? expiryDate;
  String? status;
  int? iV;

  Coupon(
      {this.sId,
      this.couponCode,
      this.discount,
      this.type,
      this.minimumCartValue,
      this.minimumMedishieldCoins,
      this.expiryDate,
      this.status,
      this.iV});

  Coupon.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    couponCode = json['couponCode'];
    discount = json['discount'];
    type = json['type'];
    minimumCartValue = json['minimumCartValue'];
    minimumMedishieldCoins = json['minimumMedishieldCoins'];
    expiryDate = json['expiryDate'];
    status = json['status'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['couponCode'] = couponCode;
    data['discount'] = discount;
    data['type'] = type;
    data['minimumCartValue'] = minimumCartValue;
    data['minimumMedishieldCoins'] = minimumMedishieldCoins;
    data['expiryDate'] = expiryDate;
    data['status'] = status;
    data['__v'] = iV;
    return data;
  }
}
