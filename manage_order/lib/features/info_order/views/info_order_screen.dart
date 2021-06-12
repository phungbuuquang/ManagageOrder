import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_order/components/widgets/common_dialog_notification.dart';
import 'package:manage_order/data/models/local/order_request.dart';

import '../../../components/base/base_statefull.dart';
import '../../../components/widgets/my_button.dart';
import '../../../components/widgets/my_checkbox.dart';
import '../../../components/widgets/my_dropdown_button.dart';
import '../../../components/widgets/my_text_form_field.dart';
import '../../../data/models/local/item_stock.dart';
import '../../../data/models/remote/fee_vehicle.dart';
import '../../../data/models/remote/truck_data.dart';
import '../../../data/models/remote/unit_data.dart';
import '../../../data/models/remote/warehouse_data.dart';
import '../../../styles/theme.dart';
import '../../routes.dart';
import '../bloc/info_order_bloc.dart';

part 'info_order_children.dart';

class InfoOrderScreen extends StatefulWidget {
  @override
  _InfoOrderScreenState createState() => _InfoOrderScreenState();
}

class _InfoOrderScreenState extends StatefulWidgetBase<InfoOrderScreen> {
  InfoOrderBloc get _bloc => BlocProvider.of(context);

  List<FeeVehicle> listFee = [];
  List<TruckData> listTrucks = [];
  List<WarehouseData> listWarehouses = [];
  List<UnitData> listUnits = [];
  List<ItemStock> listStocks = [];
  FeeVehicle? _fee;
  int? _numVehicle;
  String? _nameCustomer;
  int? _idTruck;
  int? _idWarehouse;
  OrderRequest? orderRequest;

  late String selectedVal;
  @override
  void initState() {
    super.initState();
    _bloc.add(GetListInfoStockEvent());
    _bloc.add(GetFeeVehiclesEvent());
    _bloc.add(CheckTruckEvent(false));
    _bloc.add(CheckWarehouseEvent(false));
    _bloc.add(GetListUnitsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Stack(children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Thông tin đơn hàng'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Thông tin cơ bản',
                      style: AppTextTheme.getTextTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _buildListInfoCustomer(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Danh sách hàng hóa',
                      style: AppTextTheme.getTextTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _buildListInfoStock(),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildCheckTruck(),
                    _buildCheckWarehouse()
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocListener<InfoOrderBloc, InfoOrderState>(
                  listenWhen: (prev, current) {
                    return current is AddOrderDoneState;
                  },
                  listener: (_, state) {
                    if (state is AddOrderDoneState) {
                      Navigator.of(context).pushNamed(RouteList.printer,
                          arguments: {'order_request': orderRequest});
                    }
                  },
                  child: MyButton(
                    title: 'Xác nhận',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_context) => NotificationDialog(
                          iconImages: const Icon(Icons.warning),
                          title: 'Thông báo',
                          message: 'Bạn chắc chắn muốn gửi đơn hàng này',
                          negativeButtonName: 'Hủy',
                          nagativeButtonOnCLick: () =>
                              Navigator.of(_context).pop(),
                          possitiveButtonName: 'OK',
                          possitiveButtonOnClick: () {
                            Navigator.of(_context).pop();
                            orderRequest = OrderRequest(
                              fee: _fee,
                              soLuongXe: _numVehicle,
                              idKho: _idWarehouse,
                              idXelon: _idTruck,
                              tenKhachHang: _nameCustomer,
                              listStock: listStocks,
                            );
                            _bloc.add(
                              AddOrderSubmitEvent(orderRequest!),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<InfoOrderBloc, InfoOrderState>(
          builder: (_, state) {
            if (state is LoadingAddOrderState) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        )
      ]),
    );
  }
}
