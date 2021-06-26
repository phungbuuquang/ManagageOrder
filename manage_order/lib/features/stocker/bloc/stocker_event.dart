part of 'stocker_bloc.dart';

abstract class StockerEvent {}

class StockerGetListTruckEvent extends StockerEvent {}

class StockerGetListSmallTruckEvent extends StockerEvent {}

class StockerGetTripEvent extends StockerEvent {
  String idTruck;
  StockerGetTripEvent(this.idTruck);
}

class StockerSelectFromTruckEvent extends StockerEvent {
  TruckData? truck;
  StockerSelectFromTruckEvent(this.truck);
}

class StockerSelectSmallTruckEvent extends StockerEvent {
  TruckData? truck;
  StockerSelectSmallTruckEvent(this.truck);
}

class StockerGetInfoStockEvent extends StockerEvent {
  String code;
  StockerGetInfoStockEvent(this.code);
}

class StockerUpdateSmallTruckEvent extends StockerEvent {
  String? idSmallTruck;
  StockData stock;

  StockerUpdateSmallTruckEvent({
    this.idSmallTruck,
    required this.stock,
  });
}

class StockerCompleteTripEvent extends StockerEvent {
  String? idTruck;
  String? idTrip;

  StockerCompleteTripEvent({
    this.idTruck,
    this.idTrip,
  });
}

class StockerEditDoneEvent extends StockerEvent {
  StockData stock;
  StockerEditDoneEvent(this.stock);
}

class StockerGetStocksOfSmallTruckEvent extends StockerEvent {
  String idTruck;
  StockerGetStocksOfSmallTruckEvent(this.idTruck);
}
