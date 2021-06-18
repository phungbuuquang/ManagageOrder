part of 'stocker_bloc.dart';

abstract class StockerState extends Equatable {}

class StockerInitialState extends StockerState {
  @override
  List<Object?> get props => [const Uuid().v4()];
}

class StockerGetListTruckDoneState extends StockerState {
  final List<TruckData> listTrucks;

  StockerGetListTruckDoneState(this.listTrucks);
  @override
  List<Object?> get props => [const Uuid().v4()];
}

class StockerGetListSmallTruckDoneState extends StockerState {
  final List<TruckData> listTrucks;

  StockerGetListSmallTruckDoneState(this.listTrucks);
  @override
  List<Object?> get props => [const Uuid().v4()];
}

class StockerSelectFromTruckState extends StockerState {
  final TruckData? truck;
  StockerSelectFromTruckState(this.truck);

  @override
  List<Object?> get props => [const Uuid().v4()];
}

class StockerGetTripDoneState extends StockerState {
  final TripData? trip;
  StockerGetTripDoneState(this.trip);
  @override
  List<Object?> get props => [const Uuid().v4()];
}

class StockerSelectSmallTruckState extends StockerState {
  final TruckData? truck;
  StockerSelectSmallTruckState(this.truck);
  @override
  List<Object?> get props => [const Uuid().v4()];
}

class StockerGetInfoStockDoneState extends StockerState {
  final StockData? stock;
  StockerGetInfoStockDoneState(
    this.stock,
  );

  @override
  List<Object?> get props => [const Uuid().v4()];
}

class StockerLoadingState extends StockerState {
  @override
  List<Object?> get props => [const Uuid().v4()];
}

class StockerUpdateSmallTruckDoneState extends StockerState {
  final bool isSuccess;
  StockerUpdateSmallTruckDoneState(this.isSuccess);
  @override
  List<Object?> get props => [const Uuid().v4()];
}

class StockerCompleteTripDoneState extends StockerState {
  final bool isSuccess;
  StockerCompleteTripDoneState(this.isSuccess);
  @override
  List<Object?> get props => [const Uuid().v4()];
}
