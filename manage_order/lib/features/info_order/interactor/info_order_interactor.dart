import 'package:manage_order/data/models/local/order_request.dart';
import 'package:manage_order/data/models/remote/order_response.dart';

import '../../../data/models/remote/fee_vehicle.dart';
import '../../../data/models/remote/truck_data.dart';
import '../../../data/models/remote/unit_data.dart';
import '../../../data/models/remote/warehouse_data.dart';
import '../repository/info_order_repository.dart';

class InfoOrderInteractor {
  final InfoOrderRepository repository;
  InfoOrderInteractor({
    required this.repository,
  });

  bool validateInfoOrder(OrderRequest request) {
    if (request.soLuongXe == null || request.tenKhachHang == null) {
      return false;
    }
    final listStock = request.listStock;
    for (var i = 0; i < listStock.length; i++) {
      if (listStock[i].name == null ||
          listStock[i].number == null ||
          listStock[i].unit == null) {
        return false;
      }
    }
    if (request.truck == null && request.warehouse == null) {
      return false;
    }
    return true;
  }

  Future<List<FeeVehicle>?> getFeeVehicles() {
    return repository.getFeeVehicles();
  }

  Future<List<TruckData>?> getListTrucks() async {
    return repository.getListTrucks();
  }

  Future<List<WarehouseData>?> getListWarehouses() async {
    return repository.getListWarehouses();
  }

  Future<List<UnitData>?> getListUnits() async {
    return repository.getListUnits();
  }

  Future<OrderResponse?> addOrder(OrderRequest request) async {
    return repository.addOrder(request);
  }
}
