class order {
  String sId;
  List<String> transactions;
  String status;
  String consignment;
  User user;
  String item;
  Address address;
  String createdAt;
  String updatedAt;
  int iV;
  int amount;

  order(
      {this.sId,
      this.transactions,
      this.status,
      this.consignment,
      this.user,
      this.item,
      this.address,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.amount});

  order.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    transactions = json['transactions'].cast<String>();
    status = json['status'];
    consignment = json['consignment'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    item = json['item'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['transactions'] = this.transactions;
    data['status'] = this.status;
    data['consignment'] = this.consignment;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['item'] = this.item;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['amount'] = this.amount;
    return data;
  }
}

class User {
  String sId;
  String userId;
  String mobile;
  String firstName;
  String lastName;
  String email;
  String deviceToken;
  String status;
  String referalCode;
  String createdDate;
  String modifiedDate;

  User(
      {this.sId,
      this.userId,
      this.mobile,
      this.firstName,
      this.lastName,
      this.email,
      this.deviceToken,
      this.status,
      this.referalCode,
      this.createdDate,
      this.modifiedDate});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['UserId'];
    mobile = json['Mobile'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    deviceToken = json['DeviceToken'];
    status = json['Status'];
    referalCode = json['ReferalCode'];
    createdDate = json['CreatedDate'];
    modifiedDate = json['ModifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['UserId'] = this.userId;
    data['Mobile'] = this.mobile;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Email'] = this.email;
    data['DeviceToken'] = this.deviceToken;
    data['Status'] = this.status;
    data['ReferalCode'] = this.referalCode;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedDate'] = this.modifiedDate;
    return data;
  }
}

class Address {
  String sId;
  String addressType;
  bool isDefaultAddress;
  String user;
  int pin;
  String landMark;
  String status;
  String createdAt;
  String updatedAt;
  int iV;

  Address(
      {this.sId,
      this.addressType,
      this.isDefaultAddress,
      this.user,
      this.pin,
      this.landMark,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Address.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    addressType = json['addressType'];
    isDefaultAddress = json['isDefaultAddress'];
    user = json['user'];
    pin = json['pin'];
    landMark = json['landMark'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['addressType'] = this.addressType;
    data['isDefaultAddress'] = this.isDefaultAddress;
    data['user'] = this.user;
    data['pin'] = this.pin;
    data['landMark'] = this.landMark;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
