class UnitData {
  int? idDVT;
  String? tenDVT;

  UnitData({this.idDVT, this.tenDVT});

  UnitData.fromJson(Map<String, dynamic> json) {
    idDVT = json['idDVT'];
    tenDVT = json['TenDVT'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idDVT'] = idDVT;
    data['TenDVT'] = tenDVT;
    return data;
  }
}
