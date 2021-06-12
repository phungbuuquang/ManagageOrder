import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_order/components/depency_injection/di.dart';
import 'package:manage_order/data/models/local/order_request.dart';
import 'package:manage_order/features/home/views/home_screen.dart';
import 'package:manage_order/features/info_order/bloc/info_order_bloc.dart';
import 'package:manage_order/features/info_order/views/info_order_screen.dart';
import 'package:manage_order/features/login/bloc/login_bloc.dart';
import 'package:manage_order/features/print_bill/views/printer_screen.dart';
import 'package:manage_order/features/print_bill/views/test_printer_screen.dart';

import 'login/views/login_screen.dart';

class RouteList {
  static const String login = 'login';
  static const String farmList = 'farm_list';
  static const String home = 'home';
  static const String info_order = 'info_order';
  static const String printer = 'printer';
  static const String test_printer = 'test_printer';
}

class Routes {
  static Map<String, WidgetBuilder> _getAll(RouteSettings settings) => {
        RouteList.login: (context) {
          return BlocProvider(
            create: (_) => injector.get<LoginBloc>(),
            child: LoginScreen(),
          );
        },
        RouteList.home: (context) {
          return HomeScreen();
        },
        RouteList.info_order: (context) {
          return BlocProvider(
            create: (_) => injector.get<InfoOrderBloc>(),
            child: InfoOrderScreen(),
          );
        },
        RouteList.printer: (context) {
          final arguments = settings.arguments as Map<String, dynamic>;

          return PrinterScreen(
            orderRequest: arguments['order_request'] as OrderRequest,
          );
        },
        RouteList.test_printer: (context) {
          return TestPrinterScreen();
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
