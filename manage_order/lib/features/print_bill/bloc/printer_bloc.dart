import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_order/data/models/local/order_request.dart';
import 'package:manage_order/data/models/remote/detail_order_data.dart';
import 'package:manage_order/data/models/remote/order_response.dart';
import 'package:uuid/uuid.dart';

import '../interactor/printer_interactor.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  PrinterBloc({
    required this.interactor,
  }) : super(PrinterInitialState());

  final PrinterInteractor interactor;

  @override
  Stream<PrinterState> mapEventToState(PrinterEvent event) async* {
    if (event is CheckBluetoothEnableEvent) {
      yield* _mapCheckBluetoothEnableEventToState(event, state);
    } else if (event is PrintPressedEvent) {
      yield* _mapPrintPressedEventToState(event, state);
    } else if (event is SelectedDeviceEvent) {
      yield* _mapSelectedDeviceEventToState(event, state);
    } else if (event is GetListDevicesEvent) {
      yield* _mapGetListDevicesEventToState(event, state);
    } else if (event is PrintBillPressedEvent) {
      yield* _mapPrintBillPressedEventToState(event, state);
    } else if (event is GetListOrderDetailEvent) {
      yield* _mapGetListOrderDetailEventToState(event, state);
    } else if (event is PrintQRPressedEvent) {
      yield* _mapPrintQRPressedEventToState(event, state);
    }
  }

  Stream<PrinterState> _mapPrintQRPressedEventToState(
    PrintQRPressedEvent event,
    PrinterState state,
  ) async* {
    await interactor.printQRCodes(
      event.listDetail,
      event.bluetooth,
    );
  }

  Stream<PrinterState> _mapGetListOrderDetailEventToState(
    GetListOrderDetailEvent event,
    PrinterState state,
  ) async* {
    final isOn = await interactor.isOnBluetooh(event.bluetooth);
    if (isOn == false) {
      yield BluetoothDisableState();
      return;
    }
    final isConnected = await interactor.isConnected(event.bluetooth);
    if (isConnected == true) {
      final response = await interactor.getListDetailOrder(event.idOrder);
      if (response != null) {
        yield GetListOrderDetailDoneState(response);
      }
      return;
    }
    yield DisconnectedDeviceState();
  }

  Stream<PrinterState> _mapPrintBillPressedEventToState(
    PrintBillPressedEvent event,
    PrinterState state,
  ) async* {
    await interactor.printBill(
      event.request,
      event.qrCode,
      event.bluetooth,
    );
  }

  Stream<PrinterState> _mapGetListDevicesEventToState(
    GetListDevicesEvent event,
    PrinterState state,
  ) async* {
    final devices = await event.bluetooth.getBondedDevices();
    yield GetListBluetoothDevicesDoneState(devices);
    yield GetDeviceSelectedState(null);
  }

  Stream<PrinterState> _mapPrintPressedEventToState(
    PrintPressedEvent event,
    PrinterState state,
  ) async* {
    final isOn = await interactor.isOnBluetooh(event.bluetooth);
    if (isOn == false) {
      yield BluetoothDisableState();
      return;
    }
    final isConnected = await interactor.isConnected(event.bluetooth);
    if (isConnected == true) {
      yield ConnectedDeviceState();
      return;
    }
    yield DisconnectedDeviceState();

    // final devices = await event.bluetooth.getBondedDevices();
    // yield GetListBluetoothDevicesDoneState(devices);
  }

  Stream<PrinterState> _mapSelectedDeviceEventToState(
    SelectedDeviceEvent event,
    PrinterState state,
  ) async* {
    yield LoadingState();
    final isSuccess = await interactor.connect(event.bluetooth, event.device);
    if (isSuccess) {
      yield GetDeviceSelectedState(event.device);
      return;
    }
    yield TurnOnDeviceState();
    yield GetDeviceSelectedState(null);
    // if (isSuccess) {
    //   yield ConnectedDeviceState();
    // }
  }

  Stream<PrinterState> _mapCheckBluetoothEnableEventToState(
    CheckBluetoothEnableEvent event,
    PrinterState state,
  ) async* {
    final isOn = await event.bluetooth.isOn;
    yield isOn == true ? BluetoothEnableState() : BluetoothDisableState();
  }
}
