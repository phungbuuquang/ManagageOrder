import 'package:app_settings/app_settings.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_order/features/routes.dart';

import '../../../components/widgets/common_dialog_notification.dart';
import '../../../components/widgets/my_dropdown_form_field.dart';
import '../../../data/models/local/order_request.dart';
import '../../../data/models/local/test_print.dart';
import '../../../data/models/remote/order_response.dart';
import '../../../styles/theme.dart';
import '../bloc/printer_bloc.dart';

part 'printer_children.dart';

class PrinterScreen extends StatefulWidget {
  final OrderRequest orderRequest;
  final OrderResponse orderResponse;
  PrinterScreen({
    required this.orderRequest,
    required this.orderResponse,
  });
  @override
  _PrinterScreenState createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  PrinterBloc get _bloc => BlocProvider.of(context);

  List<BluetoothDevice> listDevices = [];

  // BluetoothDevice? _device;
  bool _connected = false;
  String? pathImage;
  TestPrint? testPrint;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetListDevicesEvent(bluetooth));

    // initPlatformState();
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
    final isOn = await bluetooth.isOn;
    print(isOn);

    // if (isConnected == false) {
    //   return;
    // }
    var devices = <BluetoothDevice>[];
    try {
      devices = await bluetooth.getBondedDevices();
      print(devices);
      _connect(devices[0]);
    } on PlatformException {
      print('exception');
    }

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
  }

  _onPrintPressed() {
    _bloc.add(PrintPressedEvent(bluetooth));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('In giấy báo hàng'),
            actions: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteList.home,
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                printersDropdownButton(),
                const SizedBox(
                  height: 20,
                ),
                _buildBillButton(context),
                const SizedBox(
                  height: 20,
                ),
                _buildPrinQRButton(context)
              ],
            ),
          ),
        ),
        BlocBuilder<PrinterBloc, PrinterState>(
          builder: (_, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  backgroundColor: Colors.grey,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }
}
