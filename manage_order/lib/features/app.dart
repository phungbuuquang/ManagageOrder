import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_order/components/depency_injection/di.dart';
import 'package:manage_order/services/prefs/app_preferences.dart';
import '../styles/theme.dart';
import 'routes.dart';

class Application extends StatelessWidget {
  // final AppStateBloc appStateBloc;
  // final AuthenticationBloc authenticationBloc;
  // final DataManager dataManager;

  const Application({Key? key}) : super(key: key);

  String get initialRoute {
    return injector.get<AppPreferences>().getIdUser() != null
        ? RouteList.home
        : RouteList.login;
  }

  List<BlocProvider> get _getProviders => [
        // BlocProvider<AuthenticationBloc>(
        //   create: (BuildContext context) => authenticationBloc,
        // ),
        // BlocProvider<AppStateBloc>(
        //   create: (BuildContext context) => appStateBloc,
        // ),
      ];

  @override
  Widget build(BuildContext context) {
    return buildMaterialApp();
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.defaultTheme,
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      locale: const Locale('vi'),
      // localizationsDelegates: const [
      //   SLocalizationsDelegate(),
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales:
      //     SLocalizationsDelegate.translations.keys.map((e) => Locale(e)),
    );
  }
}
