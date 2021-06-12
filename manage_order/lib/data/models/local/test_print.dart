import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:manage_order/data/models/local/order_request.dart';

class TestPrint {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  sample(OrderRequest data) async {
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
        bluetooth.printCustom('DATE:...............................', 0, 1);
        bluetooth.printCustom('GIẤY BÁO HÀNG', 4, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom('XE: ${data.fee?.tenPhi ?? ''}', 2, 0);
        bluetooth.printCustom('Số lượng: ${data.soLuongXe ?? ''}', 2, 0);
        bluetooth.printCustom('Tên khách: ${data.tenKhachHang ?? ''}', 2, 0);
        bluetooth.printNewLine();
        for (var i = 0; i < data.listStock.length; i++) {
          bluetooth.printCustom('${i + 1}. Hàng', 2, 0);
          bluetooth.printLeftRight('Tên:', data.listStock[i].name ?? '', 1);
          bluetooth.printLeftRight(
              'Số lượng:', data.listStock[i].number.toString(), 1);
          bluetooth.printLeftRight(
              'Đơn vị tính:', data.listStock[i].unit?.tenDVT ?? '', 1);
        }
        bluetooth.printNewLine();
        bluetooth.printCustom(
            'TT: ${data.idKho != null ? 'Vào kho' : 'Lên xe'}', 2, 0);
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
