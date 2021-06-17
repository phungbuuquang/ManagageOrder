part of 'info_order_bloc.dart';

abstract class InfoOrderState extends Equatable {
  @override
  List<Object> get props => [const Uuid().v4()];
}

class InfoOderInitialState extends InfoOrderState {}

class SelectFeeVehicleState extends InfoOrderState {
  final FeeVehicle fee;
  SelectFeeVehicleState(this.fee);
}

class GetFeeVehiclesDoneState extends InfoOrderState {
  final List<FeeVehicle> listFee;
  GetFeeVehiclesDoneState(
    this.listFee,
  );
}

class GetListTrucksDoneState extends InfoOrderState {
  final List<TruckData> listTrucks;
  GetListTrucksDoneState(
    this.listTrucks,
  );
}

class SelectTruckState extends InfoOrderState {
  final TruckData? truck;
  SelectTruckState(this.truck);
}

class CheckTruckState extends InfoOrderState {
  final bool checked;
  CheckTruckState(this.checked);
}

class GetListWarehousesDoneState extends InfoOrderState {
  final List<WarehouseData> listWarehouses;
  GetListWarehousesDoneState(
    this.listWarehouses,
  );
}

class SelectWarehouseState extends InfoOrderState {
  final WarehouseData? warehouse;
  SelectWarehouseState(this.warehouse);
}

class CheckWarehouseState extends InfoOrderState {
  final bool checked;
  CheckWarehouseState(this.checked);
}

class GetListUnitsDoneState extends InfoOrderState {
  final List<UnitData> listUnits;
  GetListUnitsDoneState(
    this.listUnits,
  );
}

class GetListInfoStockDoneState extends InfoOrderState {
  final List<ItemStock> listStocks;
  GetListInfoStockDoneState(this.listStocks);
}

class AddOrderDoneState extends InfoOrderState {
  final OrderResponse response;
  AddOrderDoneState(this.response);
}

class AddOrderFailedState extends InfoOrderState {}

class LoadingState extends InfoOrderState {}

class InvalidInfoState extends InfoOrderState {}

class ValidInfoState extends InfoOrderState {}
