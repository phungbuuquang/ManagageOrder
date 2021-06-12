import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manage_order/data/models/local/order_request.dart';
import 'package:manage_order/data/models/local/test_print.dart';
import 'package:manage_order/styles/theme.dart';

class PrinterScreen extends StatefulWidget {
  OrderRequest orderRequest;
  PrinterScreen({required this.orderRequest});
  @override
  _PrinterScreenState createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  // BluetoothDevice? _device;
  bool _connected = false;
  String? pathImage;
  TestPrint? testPrint;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    testPrint = TestPrint();
  }

  _connect(BluetoothDevice? device) {
    if (device == null) {
      print('no device selected');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (isConnected == false) {
          bluetooth.connect(device).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
      });
    }
  }

  Future<void> initPlatformState() async {
    final isConnected = await bluetooth.isConnected;
    print(isConnected);
    var devices = <BluetoothDevice>[];
    try {
      devices = await bluetooth.getBondedDevices();
      print(devices);
      _connect(devices[0]);
    } on PlatformException {}

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          print(state);
          break;
      }
    });

    // if (!mounted) return;
    // setState(() {
    //   _devices = devices;
    // });

    // if (isConnected == true) {
    //   setState(() {
    //     _connected = true;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('In giấy báo hàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => testPrint?.sample(
                widget.orderRequest,
              ),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'In biên nhận',
                        style: AppTextTheme.getTextTheme.bodyText1,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'In mã QR',
                      style: AppTextTheme.getTextTheme.bodyText1,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
