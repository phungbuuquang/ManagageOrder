import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_order/features/print_bill/bloc/printer_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/remote/stock_data.dart';
import '../../../data/models/remote/trip_data.dart';
import '../../../data/models/remote/truck_data.dart';
import '../interactor/stocker_interactor.dart';

part 'stocker_event.dart';
part 'stocker_state.dart';

class StockerBloc extends Bloc<StockerEvent, StockerState> {
  StockerBloc({
    required this.interactor,
  }) : super(StockerInitialState());

  final StockerInteractor interactor;

  @override
  Stream<StockerState> mapEventToState(StockerEvent event) async* {
    if (event is StockerGetListTruckEvent) {
      yield* _mapGetListTruckEventToState(event, state);
    } else if (event is StockerGetTripEvent) {
      yield* _mapGetTripEventToState(event, state);
    } else if (event is StockerSelectFromTruckEvent) {
      yield StockerSelectFromTruckState(event.truck);
    } else if (event is StockerGetListSmallTruckEvent) {
      yield* _mapGetListSmallTruckEventToState(event, state);
    } else if (event is StockerSelectSmallTruckEvent) {
      yield StockerSelectSmallTruckState(event.truck);
    } else if (event is StockerGetInfoStockEvent) {
      yield* _mapStockerGetInfoStockEventToState(event, state);
    } else if (event is StockerUpdateSmallTruckEvent) {
      yield* _mapStockerUpdateSmallTruckEventToState(event, state);
    } else if (event is StockerCompleteTripEvent) {
      yield* _mapStockerCompleteTripEventToState(event, state);
    }
  }

  Stream<StockerState> _mapStockerCompleteTripEventToState(
    StockerCompleteTripEvent event,
    StockerState state,
  ) async* {
    yield StockerLoadingState();
    final response =
        await interactor.completeTrip(event.idTruck ?? '', event.idTrip ?? '');
    yield StockerCompleteTripDoneState(response);
  }

  Stream<StockerState> _mapStockerUpdateSmallTruckEventToState(
    StockerUpdateSmallTruckEvent event,
    StockerState state,
  ) async* {
    yield StockerLoadingState();
    final response = await interactor.updateSmallTruck(
      event.idSmallTruck ?? '',
      event.listStock ?? [],
    );

    yield StockerUpdateSmallTruckDoneState(response);
  }

  Stream<StockerState> _mapStockerGetInfoStockEventToState(
    StockerGetInfoStockEvent event,
    StockerState state,
  ) async* {
    yield StockerLoadingState();
    final response = await interactor.getInfoStock(event.code);
    if (response != null) {
      yield StockerGetInfoStockDoneState(response);
      return;
    }
    yield StockerSelectSmallTruckState(null);
  }

  Stream<StockerState> _mapGetListSmallTruckEventToState(
    StockerGetListSmallTruckEvent event,
    StockerState state,
  ) async* {
    yield StockerLoadingState();
    final response = await interactor.getListSmallTrucks();
    if (response != null && response.isEmpty == false) {
      yield StockerGetListSmallTruckDoneState(response);
      yield StockerSelectSmallTruckState(response[0]);
      return;
    }
    yield StockerSelectSmallTruckState(null);
  }

  Stream<StockerState> _mapGetTripEventToState(
    StockerGetTripEvent event,
    StockerState state,
  ) async* {
    yield StockerLoadingState();
    final response = await interactor.getTrip(event.idTruck);
    yield StockerGetTripDoneState(response);
  }

  Stream<StockerState> _mapGetListTruckEventToState(
      StockerGetListTruckEvent event, StockerState state) async* {
    yield StockerLoadingState();
    final response = await interactor.getListTrucks();
    if (response != null && response.isEmpty == false) {
      yield StockerGetListTruckDoneState(response);
      yield StockerSelectFromTruckState(response[0]);
      return;
    }
    yield StockerSelectFromTruckState(null);
  }
}
