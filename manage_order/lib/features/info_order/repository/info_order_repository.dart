import '../../../components/depency_injection/di.dart';
import '../../../data/models/local/order_request.dart';
import '../../../data/models/remote/fee_vehicle.dart';
import '../../../data/models/remote/order_response.dart';
import '../../../data/models/remote/truck_data.dart';
import '../../../data/models/remote/unit_data.dart';
import '../../../data/models/remote/warehouse_data.dart';
import '../../../services/API_request/api_client.dart';
import '../../../services/prefs/app_preferences.dart';

class InfoOrderRepository {
  final ApiClient apiClient;
  InfoOrderRepository({
    required this.apiClient,
  });

  Future<List<FeeVehicle>?> getFeeVehicles() async {
    return apiClient.loadFeeVehicle();
  }

  Future<List<TruckData>?> getListTrucks() async {
    return apiClient.loadListFreeTruck();
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
