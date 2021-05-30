import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manage_order/data/models/local/item_menu.dart';
import 'package:manage_order/features/routes.dart';
import 'package:manage_order/styles/theme.dart';
import '../../../resources/assets/icons_constant.dart';

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
      ),
      body: _buildListMenu(),
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
