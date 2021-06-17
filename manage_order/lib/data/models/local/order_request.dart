import 'package:manage_order/data/models/local/item_stock.dart';
import 'package:manage_order/data/models/remote/fee_vehicle.dart';
import 'package:manage_order/data/models/remote/truck_data.dart';
import 'package:manage_order/data/models/remote/warehouse_data.dart';

class OrderRequest {
  FeeVehicle? fee;
  int? soLuongXe;
  String? tenKhachHang;
  TruckData? truck;
  WarehouseData? warehouse;
  List<ItemStock> listStock;

  OrderRequest({
    this.fee,
    this.soLuongXe,
    this.tenKhachHang,
    this.truck,
    this.warehouse,
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
