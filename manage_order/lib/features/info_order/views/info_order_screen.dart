import 'package:flutter/material.dart';
import 'package:manage_order/components/widgets/my_button.dart';
import 'package:manage_order/components/widgets/my_text_form_field.dart';
import 'package:manage_order/data/models/local/item_vehicle.dart';
import 'package:manage_order/features/routes.dart';
import '../../../components/base/base_statefull.dart';
import '../../../components/widgets/my_checkbox.dart';
import '../../../styles/theme.dart';

class InfoOrderScreen extends StatefulWidget {
  @override
  _InfoOrderScreenState createState() => _InfoOrderScreenState();
}

class _InfoOrderScreenState extends StatefulWidgetBase<InfoOrderScreen> {
  List<ItemVehicle> listVehicle = [
    ItemVehicle(title: 'Xe máy'),
    ItemVehicle(title: 'Xe tải'),
    ItemVehicle(title: 'Bagat'),
    ItemVehicle(title: 'Khác'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text(
                  '1. Kho bãi',
                  style: AppTextTheme.getTextTheme.bodyText1,
                ),
                _buildListSelection(),
                const SizedBox(
                  height: 20,
                ),
                _buildListInfoCustomer(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              title: 'Xác nhận',
              onPressed: () => Navigator.of(context).pushNamed(
                RouteList.printer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildListInfoCustomer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '2. Thông tin khách hàng',
          style: AppTextTheme.getTextTheme.bodyText1,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Tên khách hàng',
          style: AppTextTheme.getTextTheme.bodyText1,
        ),
        MyTextFormField(),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tên hàng',
              style: AppTextTheme.getTextTheme.bodyText1,
            ),
            MyTextFormField(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Số lượng',
              style: AppTextTheme.getTextTheme.bodyText1,
            ),
            MyTextFormField(),
          ],
        ),
      ],
    );
  }

  GridView _buildListSelection() {
    const itemHeight = 50;
    final itemWidth = device.width / 2;
    return GridView.builder(
      shrinkWrap: true,
      itemCount: listVehicle.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: itemWidth / itemHeight,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return _builItem(index);
      },
    );
  }

  Widget _builItem(int index) {
    final item = listVehicle[index];
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MyCheckbox(),
        Text(
          item.title,
          style: AppTextTheme.getTextTheme.bodyText1,
        ),
      ],
    );
  }
}
