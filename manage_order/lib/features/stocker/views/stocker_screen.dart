import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_order/components/widgets/common_dialog_notification.dart';
import 'package:scan/scan.dart';

import '../../../components/widgets/my_button.dart';
import '../../../components/widgets/my_dropdown_button.dart';
import '../../../data/models/remote/stock_data.dart';
import '../../../data/models/remote/trip_data.dart';
import '../../../data/models/remote/truck_data.dart';
import '../../../styles/theme.dart';
import '../../routes.dart';
import '../bloc/stocker_bloc.dart';

part 'stocker_children.dart';

class StockerScreen extends StatefulWidget {
  @override
  _StockerScreenState createState() => _StockerScreenState();
}

class _StockerScreenState extends State<StockerScreen> {
  ScanController controller = ScanController();
  String qrcode = 'Unknown';

  StockerBloc get _bloc => BlocProvider.of(context);

  List<StockData> listStock = [];
  TripData? trip;
  TruckData? smallTruck;
  TruckData? truck;

  @override
  void initState() {
    super.initState();
    _bloc.add(StockerGetListTruckEvent());
    _bloc.add(StockerGetListSmallTruckEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
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
                    // Text(
                    //   'Chuyến',
                    //   style: AppTextTheme.getTextTheme.headline1,
                    // ),
                    // _buidlTripBuilder(),
                    Text(
                      'Đến xe',
                      style: AppTextTheme.getTextTheme.headline1,
                    ),
                    _toTruckDropdownButton(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildScanBtn(context),
                        _buildCompleteTripBtn()
                      ],
                    ),
                    _buildListStock()
                  ],
                ),
              ),
              _buildSubmitBtn()
            ],
          ),
        ),
      ),
      BlocBuilder<StockerBloc, StockerState>(
        builder: (_, state) {
          if (state is StockerLoadingState) {
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
    ]);
  }

  Widget _buildScanBtn(BuildContext context) {
    return GestureDetector(
      onTap: scanPressed,
      child: Center(
        child: Container(
          width: 80,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              'Scan',
              style: AppTextTheme.getTextTheme.subtitle1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteTripBtn() {
    return BlocListener<StockerBloc, StockerState>(
      listener: (_, state) {
        if (state is StockerCompleteTripDoneState) {
          if (state.isSuccess) {
            _showDialog('Hoàn thành chuyến thành công');
          } else {
            _showDialog('Hoàn thành chuyến thất bại');
          }
        }
      },
      child: GestureDetector(
        onTap: () => _bloc.add(StockerCompleteTripEvent(
          idTrip: trip?.maChuyen.toString(),
          idTruck: truck?.idXe.toString(),
        )),
        child: Center(
          child: Container(
            // width: 80,
            padding: const EdgeInsets.all(5),
            height: 35,
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                'Hoàn thành chuyến',
                style: AppTextTheme.getTextTheme.subtitle1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> scanPressed() async {
    final res = await Navigator.of(context).pushNamed(RouteList.scan_qr);
    if (res != null) {
      _bloc.add(
        StockerGetInfoStockEvent(
          res.toString(),
        ),
      );
    }
  }

  Future<void> _showDialog(String msg) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return NotificationDialog(
            iconImages: const Icon(Icons.warning),
            title: 'Thông báo',
            message: msg,
            possitiveButtonName: 'OK',
            possitiveButtonOnClick: () {
              Navigator.of(ctx).pop();
            },
          );
        });
  }

  Widget _buildSubmitBtn() {
    return BlocListener<StockerBloc, StockerState>(
      listener: (_, state) {
        if (state is StockerUpdateSmallTruckDoneState) {
          if (state.isSuccess) {
            _showDialog('Cập nhật xe giao hàng thành công');
          } else {
            _showDialog('Cập nhật xe giao hàng thất bại');
          }
        }
      },
      child: MyButton(
        title: 'Hoàn thành',
        onPressed: () {
          _bloc.add(
            StockerUpdateSmallTruckEvent(
              idSmallTruck: smallTruck?.idXe.toString(),
              listStock: listStock,
            ),
          );
        },
      ),
    );
  }
}
