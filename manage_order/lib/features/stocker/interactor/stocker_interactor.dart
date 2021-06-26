import '../../../data/models/remote/stock_data.dart';
import '../../../data/models/remote/trip_data.dart';
import '../../../data/models/remote/truck_data.dart';

import '../repository/stocker_repository.dart';

class StockerInteractor {
  final StockerRepository repository;
  StockerInteractor({required this.repository});

  Future<List<TruckData>?> getListTrucks() async {
    return repository.getListTrucks();
  }

  Future<TripData?> getTrip(String idXeLon) async {
    return repository.getTrip(idXeLon);
  }

  Future<List<TruckData>?> getListSmallTrucks() async {
    return repository.getListSmallTrucks();
  }

  Future<StockData?> getInfoStock(
    String maGoiHang,
  ) async {
    return repository.getInfoStock(maGoiHang);
  }

  Future<bool> updateSmallTruck(
    String idSmallTruck,
    List<StockData> listStock,
  ) async {
    final response = await repository.updateSmallTruck(
      idSmallTruck,
      listStock,
    );
    if (response != null && response.ketQua == 1) {
      return true;
    }
    return false;
  }

  Future<bool> completeTrip(
    String idTruck,
    String idTrip,
  ) async {
    final res = await repository.completeTrip(
      idTruck,
      idTrip,
    );
    if (res != null && res.ketQua == 1) {
      return true;
    }
    return false;
  }

  Future<bool> updateSmallTruckSingleStock({
    required String idSmallTruck,
    required StockData stock,
  }) async {
    final res = await repository.updateSmallTruckSingleStock(
      idSmallTruck: idSmallTruck,
      stock: stock,
    );
    if (res != null && res.ketQua == 1) {
      return true;
    }
    return false;
  }

  Future<List<StockData>?> getStockOfSmallTruck(
    String idTruck,
  ) async {
    return repository.getStockOfSmallTruck(idTruck);
  }
}
