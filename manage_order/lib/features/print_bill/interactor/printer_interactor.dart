import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:manage_order/data/models/local/order_request.dart';
import 'package:manage_order/data/models/local/test_print.dart';
import 'package:manage_order/data/models/remote/detail_order_data.dart';
import 'package:manage_order/features/print_bill/repository/printer_repository.dart';
import 'package:manage_order/features/print_bill/views/test_printer_screen.dart';

class PrinterInteractor {
  final PrinterRepository repository;
  PrinterInteractor({required this.repository});

  Future<bool> connect(
    BlueThermalPrinter bluetooth,
    BluetoothDevice? device,
  ) async {
    if (device == null) {
      return false;
    }

    try {
      await bluetooth.disconnect();
      final bool isSuccess = await bluetooth.connect(device);
      return isSuccess;
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<bool?> isOnBluetooh(BlueThermalPrinter bluetooth) async {
    final isOn = await bluetooth.isOn;
    return isOn;
  }

  Future<bool?> isConnected(BlueThermalPrinter bluetooth) async {
    final isConnected = await bluetooth.isConnected;
    return isConnected;
  }

  Future<void> printBill(
      OrderRequest data, String qrCode, BlueThermalPrinter bluetooth) async {
    final testPrinter = TestPrint(bluetooth);
    await testPrinter.printBill(data, qrCode);
  }

  Future<void> printQRCodes(
      List<DetailOrderData> listDetail, BlueThermalPrinter bluetooth) async {
    final testPrinter = TestPrint(bluetooth);
    await testPrinter.printListQRCode(listDetail);
  }

  Future<List<DetailOrderData>?> getListDetailOrder(String idOrder) async {
    return repository.getListDetailOrder(idOrder);
  }
}
