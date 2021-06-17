import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/depency_injection/di.dart';
import '../../../data/models/local/item_menu.dart';
import '../../../resources/assets/icons_constant.dart';
import '../../../services/prefs/app_preferences.dart';
import '../../../styles/theme.dart';
import '../../routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ItemMenu> listMenu = [
    ItemMenu(
      title: 'Thêm đơn hàng',
      icon: IconConstants.order,
    ),
    ItemMenu(
      title: 'Lịch sử đơn hàng',
      icon: IconConstants.history,
    ),
  ];
  bool isBaoHang = true;
  @override
  void initState() {
    super.initState();
    final role = injector.get<AppPreferences>().getRoleUser();
    if (role == TypeUser.thukho) {
      isBaoHang = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhân Viên A'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: () {
              injector.get<AppPreferences>().clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(RouteList.login, (route) => false);
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                isBaoHang ? RouteList.info_order : RouteList.stocker),
            child: Container(
              width: 200,
              height: 200,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      IconConstants.order,
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      isBaoHang ? 'Thêm đơn hàng' : 'Phân xe giao hàng',
                      style: AppTextTheme.getTextTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.7),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconConstants.checkStock,
                      width: 30,
                      height: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      isBaoHang ? 'Kiểm hàng' : 'Thủ kho',
                      style: AppTextTheme.getTextTheme.subtitle1,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  GridView _buildListMenu() {
    return GridView.builder(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 40,
      ),
      itemCount: listMenu.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return _builItem(index);
      },
    );
  }

  Widget _builItem(int index) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(RouteList.info_order),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              listMenu[index].icon,
              width: 50,
              height: 50,
            ),
            Text(
              listMenu[index].title,
              style: AppTextTheme.getTextTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
