class DetailOrderData {
  String? maGoiHang;
  String? tenHang;
  String? soLuong;

  DetailOrderData({this.maGoiHang, this.tenHang, this.soLuong});

  DetailOrderData.fromJson(Map<String, dynamic> json) {
    maGoiHang = json['MaGoiHang'];
    tenHang = json['TenHang'];
    soLuong = json['SoLuong'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['MaGoiHang'] = maGoiHang;
    data['TenHang'] = tenHang;
    data['SoLuong'] = soLuong;
    return data;
  }
}
