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
}
