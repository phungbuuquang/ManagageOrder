import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manage_order/components/depency_injection/di.dart';
import 'package:manage_order/services/prefs/app_preferences.dart';

import '../../../data/models/local/item_menu.dart';
import '../../../resources/assets/icons_constant.dart';
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
        children: [
          Expanded(
            child: _buildListMenu(),
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
                      'Kiểm hàng',
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
