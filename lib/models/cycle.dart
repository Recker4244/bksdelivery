class cycle {
  String status;
  String sId;
  String name;
  int graceperiod;
  int minWeight;
  int minValue;
  String createdAt;
  String updatedAt;
  int iV;

  cycle(
      {this.status,
      this.sId,
      this.name,
      this.graceperiod,
      this.minWeight,
      this.minValue,
      this.createdAt,
      this.updatedAt,
      this.iV});

  cycle.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    name = json['name'];
    graceperiod = json['graceperiod'];
    minWeight = json['minWeight'];
    minValue = json['minValue'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['graceperiod'] = this.graceperiod;
    data['minWeight'] = this.minWeight;
    data['minValue'] = this.minValue;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
