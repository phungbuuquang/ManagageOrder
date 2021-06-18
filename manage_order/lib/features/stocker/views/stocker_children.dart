part of 'stocker_screen.dart';

extension _StockerChildren on _StockerScreenState {
  Widget _buidlTripBuilder() {
    return BlocBuilder<StockerBloc, StockerState>(
      buildWhen: (prev, curent) {
        return curent is StockerGetTripDoneState;
      },
      builder: (_, state) {
        if (state is StockerGetTripDoneState) {
          return _buildTripText(state.trip?.maChuyen ?? 'Không có chuyến');
        }
        return _buildTripText('Không có chuyến');
      },
    );
  }

  Padding _buildTripText(String trip) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trip,
            style: AppTextTheme.getTextTheme.bodyText1,
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            height: 1,
          )
        ],
      ),
    );
  }

  Widget _toTruckDropdownButton() {
    var listTrucks = <TruckData>[];
    return BlocConsumer<StockerBloc, StockerState>(
      listener: (_, state) {
        if (state is StockerGetListSmallTruckDoneState) {
          listTrucks = state.listTrucks;
        }
        if (state is StockerSelectSmallTruckState) {
          smallTruck = state.truck;
        }
      },
      buildWhen: (prev, current) {
        return current is StockerSelectSmallTruckState;
      },
      builder: (_, state) {
        if (state is StockerSelectSmallTruckState) {
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
                  _bloc.add(StockerSelectSmallTruckEvent(val));
                }
              },
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _fromTruckDropdownButton() {
    var listTrucks = <TruckData>[];
    return BlocConsumer<StockerBloc, StockerState>(
      listener: (_, state) {
        if (state is StockerGetListTruckDoneState) {
          listTrucks = state.listTrucks;
        }
        if (state is StockerGetTripDoneState) {
          trip = state.trip;
        }
        if (state is StockerSelectFromTruckState) {
          truck = state.truck;
          if (state.truck != null) {
            _bloc.add(
              StockerGetTripEvent(
                state.truck!.idXe.toString(),
              ),
            );
          }
        }
      },
      buildWhen: (prev, current) {
        return current is StockerSelectFromTruckState;
      },
      builder: (_, state) {
        if (state is StockerSelectFromTruckState) {
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
                  _bloc.add(StockerSelectFromTruckEvent(val));
                }
              },
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
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
