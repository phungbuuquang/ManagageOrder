class WarehouseData {
  int? idKho;
  String? tenKho;

  WarehouseData({this.idKho, this.tenKho});

  WarehouseData.fromJson(Map<String, dynamic> json) {
    idKho = json['idKho'];
    tenKho = json['TenKho'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idKho'] = idKho;
    data['TenKho'] = tenKho;
    return data;
  }
}
