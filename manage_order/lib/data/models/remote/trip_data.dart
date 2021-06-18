class TripData {
  String? maChuyen;

  TripData({
    this.maChuyen,
  });

  TripData.fromJson(Map<String, dynamic> json) {
    maChuyen = json['MaChuyen'];
  }
}
