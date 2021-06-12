class OrderResponse {
  String? soBaoHang;

  OrderResponse({this.soBaoHang});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    soBaoHang = json['SoBaoHang'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['SoBaoHang'] = soBaoHang;
    return data;
  }
}
