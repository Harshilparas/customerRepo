class CouponModel {
  int? success;
  List<Coupons>? coupons;

  CouponModel({this.success, this.coupons});

  CouponModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(Coupons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (coupons != null) {
      data['coupons'] = coupons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupons {
  int? id;
  String? name;
  String? code;
  int? amount;
  String? expiry;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;

  Coupons(
      {this.id,
        this.name,
        this.code,
        this.amount,
        this.expiry,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt});

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    name = json['name']??"";
    code = json['code']??"";
    amount = json['amount']??"";
    expiry = json['expiry']??"";
    type = json['type']??"";
    status = json['status']??"";
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['amount'] = amount;
    data['expiry'] = expiry;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}