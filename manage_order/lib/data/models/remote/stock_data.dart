class StockData {
  String? tenHang;
  String? dVT;
  int? soLuong;
  int? donGia;
  String? maGoiHang;
  String? ghiChu;

  StockData({
    this.tenHang,
    this.dVT,
    this.soLuong,
    this.donGia,
  });

  StockData.fromJson(Map<String, dynamic> json) {
    tenHang = json['TenHang'];
    dVT = json['DVT'];
    soLuong = json['SoLuong'];
    maGoiHang = json['MaGoiHang'];
    ghiChu = json['GhiChu'];
    donGia = json['DonGia'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['TenHang'] = tenHang;
    data['DVT'] = dVT;
    data['SoLuong'] = soLuong;
    data['DonGia'] = donGia;

    return data;
  }
}
