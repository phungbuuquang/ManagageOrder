import 'package:manage_order/components/depency_injection/di.dart';
import 'package:manage_order/data/models/remote/result_common.dart';
import 'package:manage_order/services/prefs/app_preferences.dart';

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

  Future<ResultCommon?> updateSmallTruck(
    String idSmallTruck,
    List<StockData> listStock,
  ) async {
    var stockCodes = '';
    listStock.forEach((element) {
      stockCodes += '${element.maGoiHang ?? ''},';
    });
    return apiClient.updateSmallTruck(
      idSmallTruck,
      injector.get<AppPreferences>().getIdUser() ?? '',
      stockCodes,
    );
  }

  Future<ResultCommon?> completeTrip(
    String idTruck,
    String idTrip,
  ) async {
    return apiClient.completeTrip(
      idTruck,
      idTrip,
    );
  }
}
