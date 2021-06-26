import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_order/components/widgets/my_radio_button.dart';
import 'package:manage_order/utils/utils.dart';

import '../../../components/base/base_statefull.dart';
import '../../../components/widgets/common_dialog_notification.dart';
import '../../../components/widgets/my_button.dart';
import '../../../components/widgets/my_checkbox.dart';
import '../../../components/widgets/my_dropdown_button.dart';
import '../../../components/widgets/my_text_form_field.dart';
import '../../../data/models/local/item_stock.dart';
import '../../../data/models/local/order_request.dart';
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
  int _numVehicle = 1;
  String? _nameCustomer;
  TruckData? _truck;
  WarehouseData? _warehouse;
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
                    Center(
                      child: Text(
                        'Danh sách hàng hóa',
                        style: AppTextTheme.getTextTheme.bodyText1,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _buildListInfoStock(),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildCheckTruck(),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildCheckWarehouse(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildSubmitBtn(context),
              ],
            ),
          ),
        ),
        BlocBuilder<InfoOrderBloc, InfoOrderState>(
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
      ]),
    );
  }
}
