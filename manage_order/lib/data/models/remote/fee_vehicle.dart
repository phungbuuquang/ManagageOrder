class FeeVehicle {
  int? idPhiXe;
  String? tenPhi;
  int? gia;

  FeeVehicle({
    this.idPhiXe,
    this.tenPhi,
    this.gia,
  });

  FeeVehicle.fromJson(Map<String, dynamic> json) {
    idPhiXe = json['idPhiXe'];
    tenPhi = json['TenPhi'];
    gia = json['Gia'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idPhiXe'] = idPhiXe;
    data['TenPhi'] = tenPhi;
    data['Gia'] = gia;
    return data;
  }
}
