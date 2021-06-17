import 'package:manage_order/data/models/remote/detail_order_data.dart';
import 'package:manage_order/services/API_request/api_client.dart';

class PrinterRepository {
  final ApiClient apiClient;
  PrinterRepository({required this.apiClient});

  Future<List<DetailOrderData>?> getListDetailOrder(String idOrder) async {
    return apiClient.getListDetailOrder(idOrder);
  }
}
