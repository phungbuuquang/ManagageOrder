part of 'info_order_bloc.dart';

abstract class InfoOrderEvent extends Equatable {
  @override
  List<Object> get props => [const Uuid().v4()];
}

class SelectFeeEvent extends InfoOrderEvent {
  final FeeVehicle fee;
  SelectFeeEvent(this.fee);
}

class SelectTruckEvent extends InfoOrderEvent {
  final TruckData truck;
  SelectTruckEvent(this.truck);
}

class GetFeeVehiclesEvent extends InfoOrderEvent {}

class GetListTrucksEvent extends InfoOrderEvent {}

class GetListWarehousesEvent extends InfoOrderEvent {}

class CheckTruckEvent extends InfoOrderEvent {
  final bool checked;
  CheckTruckEvent(this.checked);
}

class CheckWarehouseEvent extends InfoOrderEvent {
  final bool checked;
  CheckWarehouseEvent(this.checked);
}

class SelectWarehouseEvent extends InfoOrderEvent {
  final WarehouseData warehouse;
  SelectWarehouseEvent(this.warehouse);
}

class GetListUnitsEvent extends InfoOrderEvent {}

class SelectUnitEvent extends InfoOrderEvent {
  final UnitData unit;
  SelectUnitEvent(this.unit);
}

class GetListInfoStockEvent extends InfoOrderEvent {}

class AddInfoStockEvent extends InfoOrderEvent {
  List<ItemStock> listStocks;
  AddInfoStockEvent(this.listStocks);
}

class DeleteInfoStockEvent extends InfoOrderEvent {
  final int index;
  List<ItemStock> listStocks;
  DeleteInfoStockEvent(
    this.listStocks,
    this.index,
  );
}

class ChangedListInfoStockEvent extends InfoOrderEvent {
  List<ItemStock> listStocks;
  ChangedListInfoStockEvent(this.listStocks);
}

class AddOrderSubmitEvent extends InfoOrderEvent {
  final OrderRequest request;
  AddOrderSubmitEvent(this.request);
}

class ValidateInfoEvent extends InfoOrderEvent {
  final OrderRequest request;
  ValidateInfoEvent(this.request);
}
