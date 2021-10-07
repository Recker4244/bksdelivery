class standardplan {
  String sId;
  String planType;
  String name;
  CyclePeriod cyclePeriod;
  int duration;
  int bonus;
  String createdAt;
  String updatedAt;
  int iV;

  standardplan(
      {this.sId,
      this.planType,
      this.name,
      this.cyclePeriod,
      this.duration,
      this.bonus,
      this.createdAt,
      this.updatedAt,
      this.iV});

  standardplan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planType = json['planType'];
    name = json['name'];
    cyclePeriod = json['cyclePeriod'] != null
        ? new CyclePeriod.fromJson(json['cyclePeriod'])
        : null;
    duration = json['duration'];
    bonus = json['bonus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['planType'] = this.planType;
    data['name'] = this.name;
    if (this.cyclePeriod != null) {
      data['cyclePeriod'] = this.cyclePeriod.toJson();
    }
    data['duration'] = this.duration;
    data['bonus'] = this.bonus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class CyclePeriod {
  String sId;
  String name;
  int graceperiod;
  int minWeight;
  int minValue;

  CyclePeriod(
      {this.sId, this.name, this.graceperiod, this.minWeight, this.minValue});

  CyclePeriod.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    graceperiod = json['graceperiod'];
    minWeight = json['minWeight'];
    minValue = json['minValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['graceperiod'] = this.graceperiod;
    data['minWeight'] = this.minWeight;
    data['minValue'] = this.minValue;
    return data;
  }
}
