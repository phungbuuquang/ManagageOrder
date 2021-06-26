import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/base/base_statefull.dart';
import '../../../components/widgets/common_dialog_notification.dart';
import '../../../components/widgets/my_button.dart';
import '../../../components/widgets/my_text_form_field.dart';
import '../../../styles/theme.dart';
import '../../routes.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends StatefulWidgetBase<LoginScreen> {
  LoginBloc get _bloc => BlocProvider.of(context);

  final _nameFieldKey = GlobalKey<FormFieldState<String>>();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  String? _name;
  String? _pass;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (_, state) {
        if (state is LoginFailedState) {
          showDialog(
            context: context,
            builder: (_context) {
              return NotificationDialog(
                  iconImages: const Icon(Icons.warning),
                  title: 'Đăng nhập thất bại',
                  message: 'Tên đăng nhập hoặc mật khẩu không đúng!',
                  possitiveButtonName: 'OK',
                  possitiveButtonOnClick: () {
                    Navigator.of(_context).pop();
                  });
            },
          );
        } else if (state is LoginSuccessState) {
          Navigator.of(context).pushReplacementNamed(RouteList.home);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: GestureDetector(
            onTap: hideKeyboard,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Theme.of(context).accentColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
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
                        'HongNam',
                        style: AppTextTheme.getLogoTextTheme.bodyText1,
                      ),
                      Column(
                        children: [
                          nameTextFormField,
                          const SizedBox(
                            height: 10,
                          ),
                          passTextFormField,
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<LoginBloc, LoginState>(
                              builder: (_, state) {
                            return MyButton(
                              title: 'Đăng nhập',
                              isLoading: state is LoginLoadingState,
                              onPressed: () {
                                if ((_name == null || _name?.isEmpty == true) ||
                                    (_pass == null || _pass?.isEmpty == true)) {
                                  _nameFieldKey.currentState?.validate();
                                  _passwordFieldKey.currentState?.validate();
                                } else {
                                  _bloc.add(LoginSubmitEvent(
                                      _name ?? '', _pass ?? ''));
                                }
                              },
                            );
                          })
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  MyTextFormField get nameTextFormField => MyTextFormField(
        fieldKey: _nameFieldKey,
        labelText: 'Tên đăng nhập',
        onTap: () {
          _nameFieldKey.currentState?.validate();
        },
        onChange: (val) {
          _name = val;
          _nameFieldKey.currentState?.didChange(val);
          _nameFieldKey.currentState?.validate();
        },
        onFieldSubmitted: (val) {
          _nameFieldKey.currentState?.validate();
        },
        validator: (String? val) {
          if (val?.isEmpty == true) {
            return 'Bắt buộc phải nhập tên đăng nhập';
          }
          return null;
        },
      );

  MyTextFormField get passTextFormField => MyTextFormField(
        fieldKey: _passwordFieldKey,
        labelText: 'Mật khẩu',
        isSecure: true,
        onTap: () {
          _passwordFieldKey.currentState?.validate();
        },
        onChange: (val) {
          _pass = val;
          _passwordFieldKey.currentState?.didChange(val);
          _passwordFieldKey.currentState?.validate();
        },
        onFieldSubmitted: (val) {
          _passwordFieldKey.currentState?.validate();
        },
        validator: (String? val) {
          if (val?.isEmpty == true) {
            return 'Bắt buộc phải nhập mật khẩu';
          }
          return null;
        },
      );
}
