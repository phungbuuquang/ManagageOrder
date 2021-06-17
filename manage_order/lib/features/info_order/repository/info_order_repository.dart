import 'package:manage_order/components/depency_injection/di.dart';
import 'package:manage_order/data/models/local/order_request.dart';
import 'package:manage_order/data/models/remote/fee_vehicle.dart';
import 'package:manage_order/data/models/remote/order_response.dart';
import 'package:manage_order/data/models/remote/truck_data.dart';
import 'package:manage_order/data/models/remote/unit_data.dart';
import 'package:manage_order/data/models/remote/warehouse_data.dart';
import 'package:manage_order/services/API_request/api_client.dart';
import 'package:manage_order/services/prefs/app_preferences.dart';

class InfoOrderRepository {
  final ApiClient apiClient;
  InfoOrderRepository({
    required this.apiClient,
  });

  Future<List<FeeVehicle>?> getFeeVehicles() async {
    return apiClient.loadFeeVehicle();
  }

  Future<List<TruckData>?> getListTrucks() async {
    return apiClient.loadListTrucks();
  }

  Future<List<WarehouseData>?> getListWarehouses() async {
    return apiClient.loadListWarehouses();
  }

  Future<List<UnitData>?> getListUnits() async {
    return apiClient.loadListUnits();
  }

  Future<OrderResponse?> addOrder(OrderRequest request) async {
    final dataOrder = request.orderData();
    final response = await apiClient.addOrder(
      idXeLon:
          request.truck != null ? (request.truck?.idXe.toString() ?? '') : '',
      idNguoiDung: injector.get<AppPreferences>().getIdUser() ?? '',
      idKho: request.warehouse != null
          ? (request.warehouse?.idKho.toString() ?? '')
          : '',
      idPhiXe:
          request.fee?.idPhiXe != null ? request.fee!.idPhiXe.toString() : '',
      soLuongXe: request.soLuongXe != null ? request.soLuongXe.toString() : '',
      tenKhachHang: request.tenKhachHang ?? '',
      chuoihang: dataOrder,
    );
    return response;
  }
}
