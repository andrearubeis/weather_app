import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/common/config/environment.dart';
import 'package:weather_app/common/config/scroll_configuration.dart';
import 'package:weather_app/common/helper/ui_helper.dart';
import 'package:weather_app/common/interceptor/error_interceptor.dart';
import 'package:weather_app/common/localization/app_localizations.dart';
import 'package:weather_app/common/navigation/navigation.dart';
import 'package:weather_app/common/style/app_theme.dart';
import 'package:weather_app/pages/splash_page/splash_page.dart';
import 'package:weather_app/pages/splash_page/splash_view_model.dart';

GetIt locator = GetIt.instance;

void main() {
  locator.registerLazySingleton(() => Configuration());
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {

  StreamSubscription<WeatherError> weatherErrorSubscription;

  @override
  void initState() {
    super.initState();
    weatherErrorSubscription = ErrorInterceptor.errorStreamOut.listen((event) {
      BuildContext currentContext = Navigation.navKey.currentState.overlay.context;
      Future.delayed(Duration(seconds: 1), () {
        UIHelper.showFlushBar(currentContext,
            message: event.message,
            backgroundColor: WeatherAppTheme.status(currentContext)
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    weatherErrorSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WeatherApp',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        navigatorKey: Navigation.navKey,
        onGenerateRoute: Navigation.getRoute,
        home: SplashPage(SplashViewModel()),
        builder: (BuildContext context, Widget child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
                data: data.copyWith(
                    textScaleFactor:
                    data.textScaleFactor > 1.2 ? 1.2 : data.textScaleFactor),
                child: ScrollConfiguration(
                    behavior: CustomScrollBehaviour(),
                    child: child
                ),
            );
        },
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          Locale('en'),
          Locale('it'),
        ]);

  }
}

