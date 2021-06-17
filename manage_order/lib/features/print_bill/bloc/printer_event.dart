part of 'printer_bloc.dart';

abstract class PrinterEvent {}

class CheckBluetoothEnableEvent extends PrinterEvent {
  BlueThermalPrinter bluetooth;
  CheckBluetoothEnableEvent(this.bluetooth);
}

class PrintPressedEvent extends PrinterEvent {
  BlueThermalPrinter bluetooth;
  PrintPressedEvent(this.bluetooth);
}

class SelectedDeviceEvent extends PrinterEvent {
  BluetoothDevice? device;
  BlueThermalPrinter bluetooth;
  SelectedDeviceEvent(
    this.bluetooth,
    this.device,
  );
}

class GetListDevicesEvent extends PrinterEvent {
  BlueThermalPrinter bluetooth;
  GetListDevicesEvent(this.bluetooth);
}

class PrintBillPressedEvent extends PrinterEvent {
  OrderRequest request;
  BlueThermalPrinter bluetooth;
  String qrCode;
  PrintBillPressedEvent(this.request, this.qrCode, this.bluetooth);
}

class PrintQRPressedEvent extends PrinterEvent {
  List<DetailOrderData> listDetail;
  BlueThermalPrinter bluetooth;

  PrintQRPressedEvent(this.listDetail, this.bluetooth);
}

class GetListOrderDetailEvent extends PrinterEvent {
  String idOrder;
  BlueThermalPrinter bluetooth;
  GetListOrderDetailEvent(
    this.idOrder,
    this.bluetooth,
  );
}
