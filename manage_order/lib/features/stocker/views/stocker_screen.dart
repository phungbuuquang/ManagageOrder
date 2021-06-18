import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_order/data/models/remote/stock_data.dart';
import 'package:scan/scan.dart';

import '../../../components/widgets/my_button.dart';
import '../../../components/widgets/my_dropdown_button.dart';
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
                    Text(
                      'Chuyến',
                      style: AppTextTheme.getTextTheme.headline1,
                    ),
                    _buidlTripBuilder(),
                    Text(
                      'Đến xe',
                      style: AppTextTheme.getTextTheme.headline1,
                    ),
                    _toTruckDropdownButton(),
                    GestureDetector(
                      onTap: () async {
                        var res = await Navigator.of(context)
                            .pushNamed(RouteList.scan_qr);
                        if (res != null) {
                          _bloc.add(
                            StockerGetInfoStockEvent(
                              res.toString(),
                            ),
                          );
                        }
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
                    ),
                    _buildListStock()
                  ],
                ),
              ),
              MyButton(title: 'Hoàn thành')
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

  Widget _buildListStock() {
    return BlocConsumer<StockerBloc, StockerState>(
      listener: (_, state) {
        if (state is StockerGetInfoStockDoneState) {
          if (state.stock != null) {
            listStock.add(state.stock!);
          }
        }
      },
      buildWhen: (prev, current) {
        return current is StockerGetInfoStockDoneState;
      },
      builder: (_, state) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listStock.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          itemBuilder: (BuildContext context, int index) {
            final item = listStock[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${index + 1}. ${item.tenHang}',
                    style: AppTextTheme.getTextTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'SL: ${item.soLuong} ${item.dVT}',
                    style: AppTextTheme.getTextTheme.subtitle2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
