class OrderResponse {
  String? soBaoHang;
  String? idDonHang;

  OrderResponse({
    this.soBaoHang,
    this.idDonHang,
  });

  OrderResponse.fromJson(Map<String, dynamic> json) {
    soBaoHang = json['SoBaoHang'];
    idDonHang = json['idDonHang'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['SoBaoHang'] = soBaoHang;
    return data;
  }
}
