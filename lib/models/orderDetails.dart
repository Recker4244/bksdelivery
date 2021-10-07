class orderdetails {
  String status;
  String consignment;
  int redeemGoldApplied;
  int instantGoldApplied;
  String otp;
  double totalCharges;
  String sId;
  User user;
  Cart cart;
  Transactions transactions;
  Address address;
  DeliveryCharge deliveryCharge;
  BuySell buySell;
  String createdAt;
  String updatedAt;
  int iV;

  orderdetails(
      {this.status,
      this.consignment,
      this.redeemGoldApplied,
      this.instantGoldApplied,
      this.otp,
      this.totalCharges,
      this.sId,
      this.user,
      this.cart,
      this.transactions,
      this.address,
      this.deliveryCharge,
      this.buySell,
      this.createdAt,
      this.updatedAt,
      this.iV});

  orderdetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    consignment = json['consignment'];
    redeemGoldApplied = json['redeemGoldApplied'];
    instantGoldApplied = json['instantGoldApplied'];
    otp = json['otp'];
    totalCharges = json['totalCharges'];
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    transactions = json['transactions'] != null
        ? new Transactions.fromJson(json['transactions'])
        : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    deliveryCharge = json['deliveryCharge'] != null
        ? new DeliveryCharge.fromJson(json['deliveryCharge'])
        : null;
    buySell =
        json['buySell'] != null ? new BuySell.fromJson(json['buySell']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['consignment'] = this.consignment;
    data['redeemGoldApplied'] = this.redeemGoldApplied;
    data['instantGoldApplied'] = this.instantGoldApplied;
    data['otp'] = this.otp;
    data['totalCharges'] = this.totalCharges;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.cart != null) {
      data['cart'] = this.cart.toJson();
    }
    if (this.transactions != null) {
      data['transactions'] = this.transactions.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.deliveryCharge != null) {
      data['deliveryCharge'] = this.deliveryCharge.toJson();
    }
    if (this.buySell != null) {
      data['buySell'] = this.buySell.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String fname;
  String email;
  List<String> address;
  String pan;
  bool isWhatsapp;
  bool isInvested;
  String refCode;
  String gBPcode;
  List<String> referralBonusEntries;
  int joiningBonus;
  List<String> gBPBonusEntries;
  String sId;
  String userId;
  String mobile;
  String firstName;
  String lastName;

  String deviceToken;
  String status;
  String referalCode;
  String createdDate;
  String modifiedDate;

  User(
      {this.fname,
      this.email,
      this.address,
      this.pan,
      this.isWhatsapp,
      this.isInvested,
      this.refCode,
      this.gBPcode,
      this.referralBonusEntries,
      this.joiningBonus,
      this.gBPBonusEntries,
      this.sId,
      this.userId,
      this.mobile,
      this.firstName,
      this.lastName,
      this.deviceToken,
      this.status,
      this.referalCode,
      this.createdDate,
      this.modifiedDate});

  User.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    email = json['email'];
    address = json['address'].cast<String>();
    pan = json['pan'];
    isWhatsapp = json['isWhatsapp'];
    isInvested = json['isInvested'];
    refCode = json['refCode'];
    gBPcode = json['GBPcode'];
    referralBonusEntries = json['referralBonusEntries'].cast<String>();
    joiningBonus = json['joiningBonus'];
    gBPBonusEntries = json['GBPBonusEntries'].cast<String>();
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
    data['fname'] = this.fname;
    data['email'] = this.email;
    data['address'] = this.address;
    data['pan'] = this.pan;
    data['isWhatsapp'] = this.isWhatsapp;
    data['isInvested'] = this.isInvested;
    data['refCode'] = this.refCode;
    data['GBPcode'] = this.gBPcode;
    data['referralBonusEntries'] = this.referralBonusEntries;
    data['joiningBonus'] = this.joiningBonus;
    data['GBPBonusEntries'] = this.gBPBonusEntries;
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

class Cart {
  String sId;
  String user;
  List<Items> items;
  String createdAt;
  String updatedAt;
  int iV;

  Cart(
      {this.sId,
      this.user,
      this.items,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Cart.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Items {
  String sId;
  Item item;
  int quantity;

  Items({this.sId, this.item, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.item != null) {
      data['item'] = this.item.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

class Item {
  List<Charges> charges;
  String sId;
  String category;
  String variety;
  String product;
  int grossweight;
  String description;
  String sKU;
  int units;
  String ringsize;
  String measurements;
  List<String> composition;
  int iV;
  String createdAt;
  String updatedAt;
  String item;

  Item(
      {this.charges,
      this.sId,
      this.category,
      this.variety,
      this.product,
      this.grossweight,
      this.description,
      this.sKU,
      this.units,
      this.ringsize,
      this.measurements,
      this.composition,
      this.iV,
      this.createdAt,
      this.updatedAt,
      this.item});

  Item.fromJson(Map<String, dynamic> json) {
    if (json['charges'] != null) {
      charges = new List<Charges>();
      json['charges'].forEach((v) {
        charges.add(new Charges.fromJson(v));
      });
    }
    sId = json['_id'];
    category = json['category'];
    variety = json['variety'];
    product = json['product'];
    grossweight = json['grossweight'];
    description = json['description'];
    sKU = json['SKU'];
    units = json['units'];
    ringsize = json['ringsize'];
    measurements = json['measurements'];
    composition = json['composition'].cast<String>();
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.charges != null) {
      data['charges'] = this.charges.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['category'] = this.category;
    data['variety'] = this.variety;
    data['product'] = this.product;
    data['grossweight'] = this.grossweight;
    data['description'] = this.description;
    data['SKU'] = this.sKU;
    data['units'] = this.units;
    data['ringsize'] = this.ringsize;
    data['measurements'] = this.measurements;
    data['composition'] = this.composition;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['item'] = this.item;
    return data;
  }
}

class Charges {
  String status;
  String sId;

  String type;
  int percentage;
  String createdAt;
  String updatedAt;
  int iV;
  String sno;
  String createdDate;
  String modifiedDate;

  Charges(
      {this.status,
      this.sId,
      this.type,
      this.percentage,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.sno,
      this.createdDate,
      this.modifiedDate});

  Charges.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    sId = json['_id'];
    status = json['status'];
    type = json['Type'];
    percentage = json['Percentage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    sno = json['Sno'];
    createdDate = json['CreatedDate'];
    modifiedDate = json['ModifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['Type'] = this.type;
    data['Percentage'] = this.percentage;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['Sno'] = this.sno;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedDate'] = this.modifiedDate;
    return data;
  }
}

class Transactions {
  String mode;
  int amount;
  String sId;
  List<String> instantGoldApplied;
  String paymentId;
  String status;
  User deleveryAgent;
  String createdAt;
  String updatedAt;
  int iV;

  Transactions(
      {this.mode,
      this.amount,
      this.sId,
      this.instantGoldApplied,
      this.paymentId,
      this.status,
      this.deleveryAgent,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Transactions.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    amount = json['amount'];
    sId = json['_id'];
    instantGoldApplied = json['instantGoldApplied'].cast<String>();
    paymentId = json['paymentId'];
    status = json['status'];
    deleveryAgent = json['deleveryAgent'] != null
        ? new User.fromJson(json['deleveryAgent'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    data['amount'] = this.amount;
    data['_id'] = this.sId;
    data['instantGoldApplied'] = this.instantGoldApplied;
    data['paymentId'] = this.paymentId;
    data['status'] = this.status;
    if (this.deleveryAgent != null) {
      data['deleveryAgent'] = this.deleveryAgent.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Address {
  String addressType;
  bool isDefaultAddress;
  String sId;
  String user;
  int pin;
  String landMark;
  String status;
  String createdAt;
  String updatedAt;
  int iV;

  Address(
      {this.addressType,
      this.isDefaultAddress,
      this.sId,
      this.user,
      this.pin,
      this.landMark,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Address.fromJson(Map<String, dynamic> json) {
    addressType = json['addressType'];
    isDefaultAddress = json['isDefaultAddress'];
    sId = json['_id'];
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
    data['addressType'] = this.addressType;
    data['isDefaultAddress'] = this.isDefaultAddress;
    data['_id'] = this.sId;
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

class DeliveryCharge {
  String type;
  double percentage;

  DeliveryCharge({this.type, this.percentage});

  DeliveryCharge.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    percentage = json['Percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['Percentage'] = this.percentage;
    return data;
  }
}

class BuySell {
  Kt24 kt24;

  BuySell({this.kt24});

  BuySell.fromJson(Map<String, dynamic> json) {
    kt24 = json['kt24'] != null ? new Kt24.fromJson(json['kt24']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kt24 != null) {
      data['kt24'] = this.kt24.toJson();
    }
    return data;
  }
}

class Kt24 {
  int buy;
  int sell;

  Kt24({this.buy, this.sell});

  Kt24.fromJson(Map<String, dynamic> json) {
    buy = json['buy'];
    sell = json['sell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buy'] = this.buy;
    data['sell'] = this.sell;
    return data;
  }
}
