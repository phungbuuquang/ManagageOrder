import 'package:flutter/material.dart';
import 'package:manage_order/features/routes.dart';
import '../../../components/base/base_statefull.dart';
import '../../../components/widgets/my_button.dart';
import '../../../components/widgets/my_text_form_field.dart';
import '../../../styles/theme.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends StatefulWidgetBase<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: GestureDetector(
          onTap: hideKeyboard,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.white,
                Theme.of(context).accentColor,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
                top: 50,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'XEP',
                    style: AppTextTheme.getLogoTextTheme.bodyText1,
                  ),
                  Column(
                    children: [
                      MyTextFormField(
                        hintText: 'Tên đăng nhập',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextFormField(
                        hintText: 'Mật khẩu',
                        isSecure: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyButton(
                        title: 'Đăng nhập',
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(RouteList.home),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
