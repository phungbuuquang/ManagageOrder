import 'package:flutter/material.dart';
import 'package:manage_order/components/widgets/currency_text_filed.dart';

import '../../../components/widgets/my_button.dart';
import '../../../components/widgets/my_text_form_field.dart';
import '../../../data/models/remote/stock_data.dart';
import '../../../styles/theme.dart';
import '../../../utils/utils.dart';

class InfoStockDialog extends StatelessWidget {
  InfoStockDialog({
    required this.stock,
  });
  final StockData stock;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên hàng: ${stock.tenHang}',
                      style: AppTextTheme.getTextTheme.subtitle2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Đơn vị tính: ${stock.dVT}',
                      style: AppTextTheme.getTextTheme.subtitle2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CurrencyTextField(
                      height: 50,
                      labelText: 'Giá',
                      initialValue: stock.donGia,
                      onChange: (val) {
                        stock.donGia = int.parse(val);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      height: 50,
                      labelText: 'Ghi chú',
                      initialValue: stock.ghiChu,
                      onChange: (val) {
                        stock.ghiChu = val;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyButton(
                            title: 'Lưu',
                            onPressed: () => Navigator.of(context).pop(stock),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
