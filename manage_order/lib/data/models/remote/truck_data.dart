class TruckData {
  int? idXe;
  String? bienSoXe;

  TruckData({this.idXe, this.bienSoXe});

  TruckData.fromJson(Map<String, dynamic> json) {
    idXe = json['idXe'];
    bienSoXe = json['BienSoXe'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idXe'] = idXe;
    data['BienSoXe'] = bienSoXe;
    return data;
  }
}
