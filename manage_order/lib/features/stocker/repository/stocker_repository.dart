import '../../../data/models/remote/stock_data.dart';
import '../../../data/models/remote/trip_data.dart';
import '../../../data/models/remote/truck_data.dart';
import '../../../services/API_request/api_client.dart';

class StockerRepository {
  ApiClient apiClient;
  StockerRepository({required this.apiClient});

  Future<List<TruckData>?> getListTrucks() async {
    return apiClient.loadListTrucks();
  }

  Future<TripData?> getTrip(String idXeLon) async {
    return apiClient.getTrip(idXeLon);
  }

  Future<List<TruckData>?> getListSmallTrucks() async {
    return apiClient.loadListSmallTrucks();
  }

  Future<StockData?> getInfoStock(
    String maGoiHang,
  ) async {
    return apiClient.getInfoStock(maGoiHang);
  }
}
