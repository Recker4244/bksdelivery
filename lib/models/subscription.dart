class subscription {
  String sId;
  String status;
  int unpaidSkips;
  int skipCount;
  int unpaidInvestments;
  User user;
  List<Installments> installments;
  Plan plan;
  String createdAt;
  String updatedAt;
  int iV;
  int savedAmount;
  int savedWeight;
  int totalBonus;

  subscription(
      {this.sId,
      this.status,
      this.unpaidSkips,
      this.skipCount,
      this.unpaidInvestments,
      this.user,
      this.installments,
      this.plan,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.savedAmount,
      this.savedWeight,
      this.totalBonus});

  subscription.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    unpaidSkips = json['unpaidSkips'];
    skipCount = json['skipCount'];
    unpaidInvestments = json['unpaidInvestments'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['installments'] != null) {
      installments = new List<Installments>();
      json['installments'].forEach((v) {
        installments.add(new Installments.fromJson(v));
      });
    }
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    savedAmount = json['savedAmount'];
    savedWeight = json['savedWeight'];
    totalBonus = json['totalBonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['unpaidSkips'] = this.unpaidSkips;
    data['skipCount'] = this.skipCount;
    data['unpaidInvestments'] = this.unpaidInvestments;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.installments != null) {
      data['installments'] = this.installments.map((v) => v.toJson()).toList();
    }
    if (this.plan != null) {
      data['plan'] = this.plan.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['savedAmount'] = this.savedAmount;
    data['savedWeight'] = this.savedWeight;
    data['totalBonus'] = this.totalBonus;
    return data;
  }
}

class User {
  String sId;

  User({this.sId});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    return data;
  }
}

class Installments {
  String sId;
  String paymentmode;
  String amount;
  String gold;
  String bonusSaved;
  String userId;
  String collectorId;
  String paymentId;
  String statustype;
  String createdAt;
  String updatedAt;
  int iV;

  Installments(
      {this.sId,
      this.paymentmode,
      this.amount,
      this.gold,
      this.bonusSaved,
      this.userId,
      this.collectorId,
      this.paymentId,
      this.statustype,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Installments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    paymentmode = json['paymentmode'];
    amount = json['amount'].toString();
    gold = json['gold'].toString();
    bonusSaved = json['bonus_saved'];
    userId = json['user_id'];
    collectorId = json['collector_id'];
    paymentId = json['paymentId'];
    statustype = json['statustype'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['paymentmode'] = this.paymentmode;
    data['amount'] = this.amount;
    data['gold'] = this.gold;
    data['bonus_saved'] = this.bonusSaved;
    data['user_id'] = this.userId;
    data['collector_id'] = this.collectorId;
    data['paymentId'] = this.paymentId;
    data['statustype'] = this.statustype;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Plan {
  String sId;
  String planType;
  String name;
  String cyclePeriod;
  int duration;
  int bonus;
  String createdAt;
  String updatedAt;
  int iV;
  String mode;

  Plan(
      {this.sId,
      this.planType,
      this.name,
      this.cyclePeriod,
      this.duration,
      this.bonus,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.mode});

  Plan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planType = json['planType'];
    name = json['name'];
    cyclePeriod = json['cyclePeriod'];
    duration = json['duration'];
    bonus = json['bonus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['planType'] = this.planType;
    data['name'] = this.name;
    data['cyclePeriod'] = this.cyclePeriod;
    data['duration'] = this.duration;
    data['bonus'] = this.bonus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['mode'] = this.mode;
    return data;
  }
}
