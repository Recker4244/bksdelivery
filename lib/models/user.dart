class userdata {
  String fname;
  String email;
  List<String> addresses;
  String pan;
  bool isWhatsapp;
  bool isInvested;
  String refCode;
  String gBPcode;
  List<String> referralBonusEntries;
  String joiningBonus;
  List<String> gBPBonusEntries;
  String sId;
  List<String> address;
  int mobile;
  String createdAt;
  String updatedAt;
  int iV;
  String dob;
  Referral referral;

  userdata(
      {this.fname,
      this.email,
      this.addresses,
      this.pan,
      this.isWhatsapp,
      this.isInvested,
      this.refCode,
      this.gBPcode,
      this.referralBonusEntries,
      this.joiningBonus,
      this.gBPBonusEntries,
      this.sId,
      this.address,
      this.mobile,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.dob,
      this.referral});

  userdata.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    email = json['email'];
    addresses = json['addresses'].cast<String>();
    pan = json['pan'];
    isWhatsapp = json['isWhatsapp'];
    isInvested = json['isInvested'];
    refCode = json['refCode'];
    gBPcode = json['GBPcode'];
    referralBonusEntries = json['referralBonusEntries'].cast<String>();
    joiningBonus = json['joiningBonus'].toString();
    gBPBonusEntries = json['GBPBonusEntries'].cast<String>();
    sId = json['_id'];
    address = json['address'].cast<String>();
    mobile = json['mobile'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    dob = json['dob'];
    referral = json['referral'] != null
        ? new Referral.fromJson(json['referral'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['email'] = this.email;
    data['addresses'] = this.addresses;
    data['pan'] = this.pan;
    data['isWhatsapp'] = this.isWhatsapp;
    data['isInvested'] = this.isInvested;
    data['refCode'] = this.refCode;
    data['GBPcode'] = this.gBPcode;
    data['referralBonusEntries'] = this.referralBonusEntries;
    data['joiningBonus'] = this.joiningBonus;
    data['GBPBonusEntries'] = this.gBPBonusEntries;
    data['_id'] = this.sId;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['dob'] = this.dob;
    if (this.referral != null) {
      data['referral'] = this.referral.toJson();
    }
    return data;
  }
}

class Referral {
  String fname;
  String email;
  String refCode;
  String sId;
  int mobile;

  Referral({this.fname, this.email, this.refCode, this.sId, this.mobile});

  Referral.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    email = json['email'];
    refCode = json['refCode'];
    sId = json['_id'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['email'] = this.email;
    data['refCode'] = this.refCode;
    data['_id'] = this.sId;
    data['mobile'] = this.mobile;
    return data;
  }
}

userdata Userdata = userdata();
