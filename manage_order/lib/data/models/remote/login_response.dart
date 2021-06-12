class LoginResponse {
  int? idNguoiDung;
  String? quyen;

  LoginResponse({this.idNguoiDung, this.quyen});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    idNguoiDung = json['idNguoiDung'];
    quyen = json['Quyen'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idNguoiDung'] = idNguoiDung;
    data['Quyen'] = quyen;
    return data;
  }
}
