part of 'printer_bloc.dart';

abstract class PrinterState extends Equatable {
  @override
  List<Object> get props => [const Uuid().v4()];
}

class PrinterInitialState extends PrinterState {}

class BluetoothEnableState extends PrinterState {}

class BluetoothDisableState extends PrinterState {}

class GetListBluetoothDevicesDoneState extends PrinterState {
  final List<BluetoothDevice> listDevices;
  GetListBluetoothDevicesDoneState(this.listDevices);
}

class GetDeviceSelectedState extends PrinterState {
  final BluetoothDevice? device;
  GetDeviceSelectedState(this.device);
}

class ConnectedDeviceState extends PrinterState {}

class DisconnectedDeviceState extends PrinterState {}

class GetListOrderDetailDoneState extends PrinterState {
  final List<DetailOrderData> listDetail;
  GetListOrderDetailDoneState(this.listDetail);
}

class LoadingState extends PrinterState {}

class TurnOnDeviceState extends PrinterState {}
