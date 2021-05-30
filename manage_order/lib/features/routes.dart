import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manage_order/features/home/views/home_screen.dart';
import 'package:manage_order/features/info_order/views/info_order_screen.dart';
import 'package:manage_order/features/print_bill/views/printer_screen.dart';

import 'login/views/login_screen.dart';

class RouteList {
  static const String login = 'login';
  static const String farmList = 'farm_list';
  static const String home = 'home';
  static const String info_order = 'info_order';
  static const String printer = 'printer';
}

class Routes {
  static Map<String, WidgetBuilder> _getAll(RouteSettings settings) => {
        RouteList.login: (context) {
          return LoginScreen();
        },
        RouteList.home: (context) {
          return HomeScreen();
        },
        RouteList.info_order: (context) {
          return InfoOrderScreen();
        },
        RouteList.printer: (context) {
          return PrinterScreen();
        },
      };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final _builder = _getAll(settings)[settings.name!];
    // if ([
    //   RouteList.examQuestion,
    // ].contains(settings.name)) {
    //   return pageRouteBuilder(_builder);
    // }

    // default
    return MaterialPageRoute(
      builder: _builder!,
      settings: settings,
      fullscreenDialog: false,
    );
  }

  static PageRouteBuilder pageRouteBuilder(WidgetBuilder? _builder) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return _builder!(context);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween =
            Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
          CurveTween(curve: Curves.easeIn),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
