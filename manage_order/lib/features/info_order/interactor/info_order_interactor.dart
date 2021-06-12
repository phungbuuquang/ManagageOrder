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
