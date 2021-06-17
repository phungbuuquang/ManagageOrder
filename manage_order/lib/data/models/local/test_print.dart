import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:intl/intl.dart';
import 'package:manage_order/data/models/local/order_request.dart';
import 'package:manage_order/data/models/remote/detail_order_data.dart';
import 'package:manage_order/data/models/remote/order_response.dart';

class TestPrint {
  BlueThermalPrinter bluetooth;
  TestPrint(this.bluetooth);
  String getDateNow() {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm dd-MM-yyyy');
    final formatted = formatter.format(now);
    return formatted;
  }

  printListQRCode(List<DetailOrderData> listOrder) async {
    await bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        bluetooth.printNewLine();
        listOrder.forEach((e) {
          for (var i = 0; i < (int.parse(e.soLuong ?? '0')); i++) {
            bluetooth.printCustom(e.tenHang ?? '', 1, 1);
            bluetooth.printQRcode(e.maGoiHang ?? '', 250, 250, 1);
            bluetooth.printNewLine();
          }
        });
        bluetooth.paperCut();
      }
    });
  }

  printBill(
    OrderRequest data,
    String qrCode,
  ) async {
    await bluetooth.isConnected.then(
      (isConnected) {
        if (isConnected == true) {
          bluetooth.printNewLine();
          bluetooth.printCustom('GIẤY BÁO HÀNG', 1, 1);
          bluetooth.printQRcode(qrCode, 250, 250, 1);
          bluetooth.printNewLine();
          bluetooth.printNewLine();
          bluetooth.paperCut();
          // bluetooth.printCustom('GIẤY BÁO HÀNG', 4, 1);
          // bluetooth.printCustom('DATE: ${getDateNow()}', 0, 1);
          // bluetooth.printNewLine();
          // bluetooth.printCustom('XE: ${data.fee?.tenPhi ?? ''}', 2, 0);
          // bluetooth.printCustom('Số lượng: ${data.soLuongXe ?? ''}', 2, 0);
          // bluetooth.printCustom('Tên khách: ${data.tenKhachHang ?? ''}', 2, 0);
          // bluetooth.printNewLine();
          // for (var i = 0; i < data.listStock.length; i++) {
          //   bluetooth.printCustom(
          //     '${i + 1}. ${data.listStock[i].name ?? ' '}',
          //     1,
          //     0,
          //   );
          //   bluetooth.printCustom(
          //     'Số lượng: ${data.listStock[i].number.toString()} ${data.listStock[i].unit?.tenDVT ?? ''}',
          //     1,
          //     0,
          //   );
          // }
          // bluetooth.printNewLine();
          // bluetooth.printLeftRight(
          //     'TT: ',
          //     '${data.warehouse != null ? ('Vào kho ${data.warehouse?.tenKho ?? ''}') : ('Lên xe ${data.truck?.bienSoXe ?? ''}')}',
          //     1);
          // bluetooth.printCustom('Ký tên', 2, 0);
          // bluetooth.printNewLine();
          // bluetooth.printNewLine();
          // // bluetooth.printLeftRight('XE:', data.fee?.tenPhi ?? '', 1);
          // // bluetooth.printLeftRight('KHÁCH NHẬN:', data.tenKhachHang ?? '', 0);
          // bluetooth.printNewLine();
          // bluetooth.printNewLine();
          // bluetooth.paperCut();
          return;
        }
      },
    );
  }

  sample(
    OrderRequest data,
    String qrCode,
  ) async {
    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large text
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT

//     var response = await http.get("IMAGE_URL");
//     Uint8List bytes = response.bodyBytes;

    await bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        bluetooth.printNewLine();
        bluetooth.printQRcode(qrCode, 200, 200, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom('GIẤY BÁO HÀNG', 4, 1);
        bluetooth.printCustom('DATE: ${getDateNow()}', 0, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom('XE: ${data.fee?.tenPhi ?? ''}', 2, 0);
        bluetooth.printCustom('Số lượng: ${data.soLuongXe ?? ''}', 2, 0);
        bluetooth.printCustom('Tên khách: ${data.tenKhachHang ?? ''}', 2, 0);
        bluetooth.printNewLine();
        for (var i = 0; i < data.listStock.length; i++) {
          bluetooth.printCustom(
            '${i + 1}. ${data.listStock[i].name ?? ' '}',
            1,
            0,
          );
          bluetooth.printCustom(
            'Số lượng: ${data.listStock[i].number.toString()} ${data.listStock[i].unit?.tenDVT ?? ''}',
            1,
            0,
          );
        }
        bluetooth.printNewLine();
        bluetooth.printLeftRight(
            'TT: ',
            '${data.warehouse != null ? ('Vào kho ${data.warehouse?.tenKho ?? ''}') : ('Lên xe ${data.truck?.bienSoXe ?? ''}')}',
            1);
        bluetooth.printCustom('Ký tên', 2, 0);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        // bluetooth.printLeftRight('XE:', data.fee?.tenPhi ?? '', 1);
        // bluetooth.printLeftRight('KHÁCH NHẬN:', data.tenKhachHang ?? '', 0);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
        return;

//      bluetooth.printImageBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
        bluetooth.printLeftRight("LEFT", "RIGHT", 0);
        bluetooth.printLeftRight("LEFT", "RIGHT", 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("LEFT", "RIGHT", 2);
        bluetooth.printLeftRight("LEFT", "RIGHT", 3);
        bluetooth.printLeftRight("LEFT", "RIGHT", 4);
        String testString = " čĆžŽšŠ-H-ščđ";
        bluetooth.printCustom(testString, 1, 1, charset: "windows-1250");
        bluetooth.printLeftRight("Številka:", "18000001", 1,
            charset: "windows-1250");
        bluetooth.printCustom("Body left", 1, 0);
        bluetooth.printCustom("Body right", 0, 2);
        bluetooth.printNewLine();
        bluetooth.printCustom("Thank You", 2, 1);
        bluetooth.printNewLine();
        bluetooth.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}
