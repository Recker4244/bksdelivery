class buysellprice {
  String sId;
  Kt24 kt24;
  Kt24 kt22;
  Kt24 kt18;
  Kt24 kt14;
  Kt24 kt10;
  String createdAt;
  String updatedAt;
  int iV;

  buysellprice(
      {this.sId,
      this.kt24,
      this.kt22,
      this.kt18,
      this.kt14,
      this.kt10,
      this.createdAt,
      this.updatedAt,
      this.iV});

  buysellprice.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    kt24 = json['kt24'] != null ? new Kt24.fromJson(json['kt24']) : null;
    kt22 = json['kt22'] != null ? new Kt24.fromJson(json['kt22']) : null;
    kt18 = json['kt18'] != null ? new Kt24.fromJson(json['kt18']) : null;
    kt14 = json['kt14'] != null ? new Kt24.fromJson(json['kt14']) : null;
    kt10 = json['kt10'] != null ? new Kt24.fromJson(json['kt10']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.kt24 != null) {
      data['kt24'] = this.kt24.toJson();
    }
    if (this.kt22 != null) {
      data['kt22'] = this.kt22.toJson();
    }
    if (this.kt18 != null) {
      data['kt18'] = this.kt18.toJson();
    }
    if (this.kt14 != null) {
      data['kt14'] = this.kt14.toJson();
    }
    if (this.kt10 != null) {
      data['kt10'] = this.kt10.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Kt24 {
  String buy;
  String sell;

  Kt24({this.buy, this.sell});

  Kt24.fromJson(Map<String, dynamic> json) {
    buy = json['buy'].toString();
    sell = json['sell'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buy'] = this.buy;
    data['sell'] = this.sell;
    return data;
  }
}
