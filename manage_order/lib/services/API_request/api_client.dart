import 'package:dio/dio.dart';
import 'package:manage_order/data/models/remote/detail_order_data.dart';
import 'package:manage_order/data/models/remote/order_response.dart';
import 'package:manage_order/data/models/remote/truck_data.dart';
import 'package:manage_order/data/models/remote/unit_data.dart';
import 'package:manage_order/data/models/remote/warehouse_data.dart';
import 'package:retrofit/http.dart';

import '../../data/models/remote/fee_vehicle.dart';
import '../../data/models/remote/login_response.dart';
import 'apis.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('${Apis.login}?TenDangNhap={userName}&MatKhau={password}')
  Future<LoginResponse?> login(
    @Path('userName') String userName,
    @Path('password') String password,
  );

  @GET(Apis.loadFeeVehicle)
  Future<List<FeeVehicle>?> loadFeeVehicle();

  @GET(Apis.loadTruck)
  Future<List<TruckData>?> loadListTrucks();

  @GET(Apis.loadWarehouse)
  Future<List<WarehouseData>?> loadListWarehouses();

  @GET(Apis.loadUnit)
  Future<List<UnitData>?> loadListUnits();

  // ignore: lines_longer_than_80_chars
  @POST(
    '${Apis.addOrder}?idXeLon={idXeLon}&idNguoiDung={idNguoiDung}&idKho={idKho}&idPhiXe={idPhiXe}&SoLuongXe={SoLuongXe}&TenKhachHang={TenKhachHang}&chuoihang={chuoihang}',
  )
  Future<OrderResponse?> addOrder({
    @Path('idXeLon') required String idXeLon,
    @Path('idNguoiDung') required String idNguoiDung,
    @Path('idKho') required String idKho,
    @Path('idPhiXe') required String idPhiXe,
    @Path('SoLuongXe') required String soLuongXe,
    @Path('TenKhachHang') required String tenKhachHang,
    @Path('chuoihang') required String chuoihang,
  });
  @GET('${Apis.detailOrder}?idDonHang={idDonHang}')
  Future<List<DetailOrderData>?> getListDetailOrder(
    @Path('idDonHang') String idDonHang,
  );
}
//flutter pub run build_runner build