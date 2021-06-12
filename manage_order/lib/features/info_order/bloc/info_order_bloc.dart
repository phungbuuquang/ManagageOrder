import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_order/data/models/local/item_stock.dart';
import 'package:manage_order/data/models/local/order_request.dart';
import 'package:manage_order/data/models/remote/order_response.dart';
import 'package:manage_order/data/models/remote/truck_data.dart';
import 'package:manage_order/data/models/remote/unit_data.dart';
import 'package:manage_order/data/models/remote/warehouse_data.dart';
import 'package:manage_order/features/info_order/interactor/info_order_interactor.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/remote/fee_vehicle.dart';

part 'info_order_event.dart';
part 'info_order_state.dart';

class InfoOrderBloc extends Bloc<InfoOrderEvent, InfoOrderState> {
  InfoOrderBloc({
    required this.interactor,
  }) : super(InfoOderInitialState());

  final InfoOrderInteractor interactor;
  @override
  Stream<InfoOrderState> mapEventToState(InfoOrderEvent event) async* {
    if (event is GetFeeVehiclesEvent) {
      yield* _mapGetFeeVehiclesEventToState(event, state);
    } else if (event is GetListTrucksEvent) {
      yield* _mapGetListTrucksEventToState(event, state);
    } else if (event is SelectFeeEvent) {
      yield SelectFeeVehicleState(event.fee);
    } else if (event is SelectTruckEvent) {
      yield SelectTruckState(event.truck);
    } else if (event is CheckTruckEvent) {
      yield* _mapCheckTruckEventToState(event, state);
    } else if (event is GetListWarehousesEvent) {
      yield* _mapGetListWarehousesEventToState(event, state);
    } else if (event is SelectWarehouseEvent) {
      yield SelectWarehouseState(event.warehouse);
    } else if (event is CheckWarehouseEvent) {
      yield* _mapCheckWarehouseEventToState(event, state);
    } else if (event is GetListUnitsEvent) {
      yield* _mapGetListUnitsEventToState(event, state);
    } else if (event is SelectUnitEvent) {
      yield* _mapSelectUnitEventToState(event, state);
    } else if (event is GetListInfoStockEvent) {
      yield* _mapGetListInfoStockEventToState(event, state);
    } else if (event is AddInfoStockEvent) {
      yield* _mapAddInfoStockEventToState(event, state);
    } else if (event is DeleteInfoStockEvent) {
      yield* _mapDeleteInfoStockEventToState(event, state);
    } else if (event is ChangedListInfoStockEvent) {
      yield* _mapChangedListInfoStockEventToState(event, state);
    } else if (event is AddOrderSubmitEvent) {
      yield* _mapAddOrderSubmitEventToState(event, state);
    }
  }

  Stream<InfoOrderState> _mapAddOrderSubmitEventToState(
    AddOrderSubmitEvent event,
    InfoOrderState state,
  ) async* {
    LoadingAddOrderState();
    final response = await interactor.addOrder(
      event.request,
    );
    if (response != null) {
      yield AddOrderDoneState(response);
      return;
    }
    yield AddOrderFailedState();
  }

  Stream<InfoOrderState> _mapChangedListInfoStockEventToState(
    ChangedListInfoStockEvent event,
    InfoOrderState state,
  ) async* {
    final list = event.listStocks;
    yield GetListInfoStockDoneState(list);
  }

  Stream<InfoOrderState> _mapDeleteInfoStockEventToState(
    DeleteInfoStockEvent event,
    InfoOrderState state,
  ) async* {
    final list = event.listStocks;
    list.removeAt(event.index);
    yield GetListInfoStockDoneState(list);
  }

  Stream<InfoOrderState> _mapAddInfoStockEventToState(
    AddInfoStockEvent event,
    InfoOrderState state,
  ) async* {
    final list = event.listStocks;
    list.add(ItemStock());
    yield GetListInfoStockDoneState(list);
  }

  Stream<InfoOrderState> _mapGetListInfoStockEventToState(
    GetListInfoStockEvent event,
    InfoOrderState state,
  ) async* {
    final list = <ItemStock>[ItemStock()];
    yield GetListInfoStockDoneState(list);
  }

  Stream<InfoOrderState> _mapSelectUnitEventToState(
    SelectUnitEvent event,
    InfoOrderState state,
  ) async* {}

  Stream<InfoOrderState> _mapGetListUnitsEventToState(
    GetListUnitsEvent event,
    InfoOrderState state,
  ) async* {
    final response = await interactor.getListUnits();
    if (response != null && response.isEmpty == false) {
      yield GetListUnitsDoneState(response);
    }
  }

  Stream<InfoOrderState> _mapCheckTruckEventToState(
    CheckTruckEvent event,
    InfoOrderState state,
  ) async* {
    yield CheckTruckState(event.checked);
    if (event.checked) {
      yield CheckWarehouseState(false);
      yield SelectWarehouseState(null);
    }
  }

  Stream<InfoOrderState> _mapCheckWarehouseEventToState(
    CheckWarehouseEvent event,
    InfoOrderState state,
  ) async* {
    yield CheckWarehouseState(event.checked);
    if (event.checked) {
      yield CheckTruckState(false);
      yield SelectTruckState(null);
    }
  }

  Stream<InfoOrderState> _mapGetFeeVehiclesEventToState(
    GetFeeVehiclesEvent event,
    InfoOrderState state,
  ) async* {
    final response = await interactor.getFeeVehicles();
    if (response != null && response.isEmpty == false) {
      yield GetFeeVehiclesDoneState(response);
      yield SelectFeeVehicleState(response[0]);
    }
  }

  Stream<InfoOrderState> _mapGetListWarehousesEventToState(
      GetListWarehousesEvent event, InfoOrderState state) async* {
    final response = await interactor.getListWarehouses();
    if (response != null && response.isEmpty == false) {
      yield GetListWarehousesDoneState(response);
      yield SelectWarehouseState(response[0]);
    }
  }

  Stream<InfoOrderState> _mapGetListTrucksEventToState(
      GetListTrucksEvent event, InfoOrderState state) async* {
    final response = await interactor.getListTrucks();
    if (response != null && response.isEmpty == false) {
      yield GetListTrucksDoneState(response);
      yield SelectTruckState(response[0]);
    }
  }
}
