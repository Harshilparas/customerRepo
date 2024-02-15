class CardModel {
  int? success;
  String? message;
  List<CardDetail>? data;

  CardModel({this.success, this.message, this.data});

  CardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CardDetail>[];
      json['data'].forEach((v) {
        data!.add(CardDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardDetail {
  dynamic ? id;
  int? userId;
  String? cardNumber;
  String? cardHolderName;
  String? cardType;
  String? expiryDate;
  int? status;
  var createdAt;
  var updatedAt;

  CardDetail(
      {this.id,
        this.userId,
        this.cardNumber,
        this.cardHolderName,
        this.cardType,
        this.expiryDate,
        this.status,
        this.createdAt,
        this.updatedAt});
  factory CardDetail.fromMap(Map<String, dynamic> map) {
    return CardDetail(
      id: map['id'],
      userId: map['user_id'],
      cardNumber: map['card_number'],
      cardHolderName: map['card_holder_name'],
      cardType: map['card_type'],
      expiryDate: map['expiry_date'],
      status: map['status'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'card_number': cardNumber,
      'card_holder_name': cardHolderName,
      'card_type': cardType,
      'expiry_date': expiryDate,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
  CardDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cardNumber = json['card_number'];
    cardHolderName = json['card_holder_name'];
    cardType = json['card_type'];
    expiryDate = json['expiry_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['card_number'] = cardNumber;
    data['card_holder_name'] = cardHolderName;
    data['card_type'] = cardType;
    data['expiry_date'] = expiryDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}