part of 'info_order_screen.dart';

extension _InfoOrderChildren on _InfoOrderScreenState {
  Column _buildCheckTruck() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BlocBuilder<InfoOrderBloc, InfoOrderState>(
                buildWhen: (prev, current) {
              return current is CheckTruckState;
            }, builder: (_, state) {
              if (state is CheckTruckState) {
                return MyCheckbox(
                  value: state.checked,
                  onChanged: (val) {
                    if (val != null) {
                      _bloc.add(CheckTruckEvent(val));
                      _bloc.add(GetListTrucksEvent());
                    }
                  },
                );
              }
              return const SizedBox.shrink();
            }),
            Text(
              'Lên xe',
              style: AppTextTheme.getTextTheme.subtitle2,
            ),
          ],
        ),
        _truckDropdownButton()
      ],
    );
  }

  Column _buildCheckWarehouse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BlocBuilder<InfoOrderBloc, InfoOrderState>(
                buildWhen: (prev, current) {
              return current is CheckWarehouseState;
            }, builder: (_, state) {
              if (state is CheckWarehouseState) {
                return MyCheckbox(
                  value: state.checked,
                  onChanged: (val) {
                    if (val != null) {
                      _bloc.add(CheckWarehouseEvent(val));
                      _bloc.add(GetListWarehousesEvent());
                    }
                  },
                );
              }
              return const SizedBox.shrink();
            }),
            Text(
              'Vào kho',
              style: AppTextTheme.getTextTheme.subtitle2,
            ),
          ],
        ),
        _warehouseDropdownButton()
      ],
    );
  }

  Widget _buildListInfoStock() {
    return BlocBuilder<InfoOrderBloc, InfoOrderState>(
      buildWhen: (prev, current) {
        return current is GetListInfoStockDoneState;
      },
      builder: (_, state) {
        if (state is GetListInfoStockDoneState) {
          final listItem = state.listStocks;
          listStocks = listItem;

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listItem.length + 1,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return index == listItem.length
                  ? _buildAddButton(context)
                  : _buildItemStock(index);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return InkWell(
      onTap: () => _bloc.add(
        AddInfoStockEvent(listStocks),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Thêm',
                style: AppTextTheme.getTextTheme.subtitle2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildItemStock(
    int index,
  ) {
    final item = listStocks[index];
    return Column(
      key: Key(
        item.name.toString() + item.number.toString() + item.unit.toString(),
      ),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${index + 1}. Thông tin hàng',
              style: AppTextTheme.getTextTheme.subtitle2,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              iconSize: 20,
              padding: const EdgeInsets.all(1),
              onPressed: () {
                _bloc.add(
                  DeleteInfoStockEvent(listStocks, index),
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        MyTextFormField(
          height: 50,
          labelText: 'Tên hàng',
          initialValue: item.name,
          onChange: (val) {
            listStocks[index].name = val;
          },
        ),
        const SizedBox(
          height: 5,
        ),
        MyTextFormField(
          height: 50,
          labelText: 'Số lượng',
          keyboardType: TextInputType.number,
          // ignore: prefer_null_aware_operators
          initialValue: item.number != null ? item.number.toString() : null,
          onChange: (val) {
            listStocks[index].number = int.parse(val);
          },
        ),
        const SizedBox(
          height: 5,
        ),
        _buildSelectionUnit(
          context: context,
          onChanged: (val) {
            listStocks[index].unit = val;
            _bloc.add(
              ChangedListInfoStockEvent(listStocks),
            );
          },
          unit: item.unit,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget _feeDropdownButton() {
    return BlocConsumer<InfoOrderBloc, InfoOrderState>(
      listener: (_, state) {
        if (state is GetFeeVehiclesDoneState) {
          listFee = state.listFee;
        }
        if (state is SelectFeeVehicleState) {
          _fee = state.fee;
        }
      },
      buildWhen: (prev, current) {
        return current is SelectFeeVehicleState;
      },
      builder: (_, state) {
        if (state is SelectFeeVehicleState) {
          return MyDropDownButton<FeeVehicle>(
            items: listFee
                .map((e) => DropdownMenuItem<FeeVehicle>(
                      value: e,
                      child: Text(
                        '${e.tenPhi ?? ''} (${'${e.gia}'})',
                      ),
                    ))
                .toList(),
            value: state.fee,
            onChanged: (FeeVehicle? val) {
              if (val != null) {
                _fee = val;
                _bloc.add(SelectFeeEvent(val));
              }
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _truckDropdownButton() {
    return BlocConsumer<InfoOrderBloc, InfoOrderState>(
      listener: (_, state) {
        if (state is GetListTrucksDoneState) {
          listTrucks = state.listTrucks;
        }
        if (state is SelectTruckState) {
          _idTruck = state.truck?.idXe;
        }
      },
      buildWhen: (prev, current) {
        return current is SelectTruckState;
      },
      builder: (_, state) {
        if (state is SelectTruckState) {
          if (state.truck != null) {
            return MyDropDownButton<TruckData>(
              items: listTrucks
                  .map((e) => DropdownMenuItem<TruckData>(
                        value: e,
                        child: Text(
                          e.bienSoXe ?? '',
                        ),
                      ))
                  .toList(),
              value: state.truck,
              onChanged: (TruckData? val) {
                if (val != null) {
                  _bloc.add(SelectTruckEvent(val));
                }
              },
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _warehouseDropdownButton() {
    return BlocConsumer<InfoOrderBloc, InfoOrderState>(
      listener: (_, state) {
        if (state is GetListWarehousesDoneState) {
          listWarehouses = state.listWarehouses;
        }
        if (state is SelectWarehouseState) {
          _idWarehouse = state.warehouse?.idKho;
        }
      },
      buildWhen: (prev, current) {
        return current is SelectWarehouseState;
      },
      builder: (_, state) {
        if (state is SelectWarehouseState) {
          if (state.warehouse != null) {
            return MyDropDownButton<WarehouseData>(
              items: listWarehouses
                  .map((e) => DropdownMenuItem<WarehouseData>(
                        value: e,
                        child: Text(
                          e.tenKho ?? '',
                        ),
                      ))
                  .toList(),
              value: state.warehouse,
              onChanged: (WarehouseData? val) {
                if (val != null) {
                  _bloc.add(SelectWarehouseEvent(val));
                }
              },
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  Column _buildListInfoCustomer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Xe',
          style: AppTextTheme.getTextTheme.headline1,
        ),
        _feeDropdownButton(),
        const SizedBox(
          height: 5,
        ),
        MyTextFormField(
          height: 50,
          labelText: 'Số lượng xe',
          onChange: (val) {
            _numVehicle = int.parse(val);
          },
          keyboardType: TextInputType.number,
        ),
        const SizedBox(
          height: 5,
        ),
        MyTextFormField(
          height: 50,
          labelText: 'Tên khách',
          onChange: (val) {
            _nameCustomer = val;
          },
        ),
      ],
    );
  }

  Widget _buildSelectionUnit({
    required BuildContext context,
    required Function(UnitData) onChanged,
    UnitData? unit,
  }) {
    return BlocConsumer<InfoOrderBloc, InfoOrderState>(
      buildWhen: (prev, current) {
        return current is GetListInfoStockDoneState;
      },
      listener: (_, state) {
        if (state is GetListUnitsDoneState) {
          listUnits = state.listUnits;
        }
      },
      builder: (_, state) {
        if (state is GetListInfoStockDoneState) {
          return InkWell(
            onTap: () {
              _showBottomSheetUnit(
                context: context,
                onChanged: onChanged,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      unit == null ? 'Chọn đơn vị tính' : (unit.tenDVT ?? ''),
                      style: unit == null
                          ? AppTextTheme.getTextTheme.headline1
                          : AppTextTheme.getTextTheme.subtitle2,
                    ),
                    const Icon(Icons.arrow_drop_down)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 1,
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  _showBottomSheetUnit({
    required BuildContext context,
    required Function(UnitData) onChanged,
  }) async {
    final action = CupertinoActionSheet(
      message: Text(
        'Chọn đơn vị',
        style: AppTextTheme.getTextTheme.headline1,
      ),
      actions: listUnits
          .map(
            (e) => CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                onChanged(e);
                Navigator.pop(context);
              },
              child: Text(
                e.tenDVT ?? '',
                style: AppTextTheme.getTextTheme.bodyText1,
              ),
            ),
          )
          .toList(),
      cancelButton: CupertinoActionSheetAction(
        isDestructiveAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Hủy'),
      ),
    );
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => action,
    );
  }
}
