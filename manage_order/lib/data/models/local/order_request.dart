import 'package:manage_order/data/models/local/item_stock.dart';
import 'package:manage_order/data/models/remote/fee_vehicle.dart';

class OrderRequest {
  FeeVehicle? fee;
  int? soLuongXe;
  String? tenKhachHang;
  int? idXelon;
  int? idKho;
  List<ItemStock> listStock;

  OrderRequest({
    this.fee,
    this.soLuongXe,
    this.tenKhachHang,
    this.idXelon,
    this.idKho,
    required this.listStock,
  });

  String orderData() {
    var data = '';
    listStock.forEach((e) {
      data +=
          // ignore: lines_longer_than_80_chars
          '${e.name ?? ''}|~|${e.unit?.idDVT.toString() ?? ''}|~|${e.number.toString()},';
    });
    return data;
  }
}
