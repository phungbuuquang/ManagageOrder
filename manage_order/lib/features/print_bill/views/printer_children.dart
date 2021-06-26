part of 'printer_screen.dart';

extension _PrinterChildren on _PrinterScreenState {
  Widget printersDropdownButton() {
    return BlocConsumer<PrinterBloc, PrinterState>(
      buildWhen: (prev, current) {
        return current is GetDeviceSelectedState;
      },
      listener: (_, state) {
        if (state is GetListBluetoothDevicesDoneState) {
          listDevices = state.listDevices;
        }
        if (state is TurnOnDeviceState) {
          _showDialogTurnOnDevice();
        }
      },
      builder: (_, state) {
        if (state is GetDeviceSelectedState) {
          return MyDropDownFormField<BluetoothDevice>(
            value: state.device,
            hintText: 'Chọn thiết bị',
            items: listDevices.length == 0
                ? [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('none'),
                    )
                  ]
                : (listDevices
                    .map((e) => DropdownMenuItem<BluetoothDevice>(
                          value: e,
                          child: Text(e.name ?? ''),
                        ))
                    .toList()),
            onChanged: (value) {
              if (value != null) {
                _bloc.add(
                  SelectedDeviceEvent(
                    bluetooth,
                    value,
                  ),
                );
              }
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPrinQRButton(BuildContext context) {
    return BlocListener<PrinterBloc, PrinterState>(
      listener: (_, state) {
        if (state is GetListOrderDetailDoneState) {
          _bloc.add(PrintQRPressedEvent(state.listDetail, bluetooth));
        }
      },
      child: GestureDetector(
        onTap: () => _bloc.add(
          GetListOrderDetailEvent(
            widget.orderResponse.idDonHang ?? '',
            bluetooth,
          ),
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
                  'In phiếu thông tin',
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
    );
  }

  _showDialogEnableBlue() {
    showDialog(
      context: context,
      builder: (ctx) {
        return NotificationDialog(
          iconImages: const Icon(
            Icons.warning,
          ),
          title: 'Thông báo',
          message: 'Vui lòng bật bluetooth và kết nối với thiết bị in',
          possitiveButtonName: 'OK',
          negativeButtonName: 'Cancel',
          nagativeButtonOnCLick: () => Navigator.of(ctx).pop(),
          possitiveButtonOnClick: () {
            Navigator.of(ctx).pop();
            AppSettings.openBluetoothSettings();
          },
        );
      },
    );
  }

  Future<void> _showDialogConnectDevice() async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return NotificationDialog(
          iconImages: const Icon(
            Icons.warning,
          ),
          title: 'Thông báo',
          message: 'Bạn chưa kết nối với bất kì thiết bị in nào',
          possitiveButtonName: 'OK',
          possitiveButtonOnClick: () {
            Navigator.of(ctx).pop();
          },
        );
      },
    );
  }

  Future<void> _showDialogTurnOnDevice() async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return NotificationDialog(
          iconImages: const Icon(
            Icons.warning,
          ),
          title: 'Thông báo',
          message: 'Vui lòng mở thiết bị in',
          possitiveButtonName: 'OK',
          possitiveButtonOnClick: () {
            Navigator.of(ctx).pop();
          },
        );
      },
    );
  }

  BlocListener<PrinterBloc, PrinterState> _buildBillButton(
      BuildContext context) {
    return BlocListener<PrinterBloc, PrinterState>(
      listener: (_, state) {
        if (state is BluetoothDisableState) {
          _showDialogEnableBlue();
        }
        if (state is GetListBluetoothDevicesDoneState) {
          print(state.listDevices.map((e) => e.name));
        }
        if (state is ConnectedDeviceState) {
          _bloc.add(PrintBillPressedEvent(
            widget.orderRequest,
            widget.orderResponse.soBaoHang ?? '',
            bluetooth,
          ));
        }
        if (state is DisconnectedDeviceState) {
          _showDialogConnectDevice();
        }
      },
      child: GestureDetector(
        onTap: _onPrintPressed,
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
                  'In phiếu báo hàng',
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
    );
  }
}
