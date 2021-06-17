import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../components/widgets/my_button.dart';
import '../../../components/widgets/my_dropdown_button.dart';
import '../../../data/models/remote/truck_data.dart';
import '../../../styles/theme.dart';

class StockerScreen extends StatefulWidget {
  const StockerScreen({Key? key}) : super(key: key);

  @override
  _StockerScreenState createState() => _StockerScreenState();
}

class _StockerScreenState extends State<StockerScreen> {
  String _scanBarcode = 'Unknown';

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phân xe giao hàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    'Từ xe',
                    style: AppTextTheme.getTextTheme.headline1,
                  ),
                  _fromTruckDropdownButton(),
                  Text(
                    'Chuyến',
                    style: AppTextTheme.getTextTheme.headline1,
                  ),
                  _fromTruckDropdownButton(),
                  Text(
                    'Đến xe',
                    style: AppTextTheme.getTextTheme.headline1,
                  ),
                  _fromTruckDropdownButton(),
                  GestureDetector(
                    onTap: () async {
                      await scanQR();
                    },
                    child: Center(
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Text('Scan'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            MyButton(title: 'Hoàn thành')
          ],
        ),
      ),
    );
  }

  Widget _fromTruckDropdownButton() {
    return MyDropDownButton<TruckData>(
      items: [],
      value: null,
      // onChanged: (FeeVehicle? val) {
      //   if (val != null) {
      //     _fee = val;
      //     _bloc.add(SelectFeeEvent(val));
      //   }
      // },
    );
  }
}
