class ResultCommon {
  int? ketQua;

  ResultCommon({this.ketQua});

  ResultCommon.fromJson(Map<String, dynamic> json) {
    ketQua = json['KetQua'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['KetQua'] = ketQua;
    return data;
  }
}
