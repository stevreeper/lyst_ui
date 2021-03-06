import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:lystui/providers/auth.provider.dart';
import 'package:lystui/providers/category.provider.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/providers/loading.provider.dart';
import 'package:lystui/providers/notes.provider.dart';
import 'package:lystui/screens/about/about.screen.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/screens/auth/auth.screen.dart';
import 'package:lystui/screens/splash/splash.screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Routes {
  //Declare main app routes
  final routes = <String, WidgetBuilder>{
    SplashScreen.routeName: (context) => SplashScreen(),
    AppScreen.routeName: (context) => AppScreen(),
    AuthScreen.routeName: (context) => AuthScreen(),
    AboutScreen.routeName: (context) => AboutScreen(),
  };

  final appTheme = ThemeData(
    primaryColor: Color(0xFFba0dab),
    primaryColorLight: Color(0xFFD134C4),
    primaryColorDark: Color(0xFF940A88),
    hintColor: Color(0xFFba0dab),
    accentColor: Color(0xFFba0dab),
    fontFamily: "Lato",
    scaffoldBackgroundColor: Colors.transparent,
    textSelectionColor: Color(0xFFba0dab),
    textSelectionHandleColor: Color(0xFFba0dab),
    appBarTheme: AppBarTheme(
      color: Color(0xFF848484).withOpacity(0.1),
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: Color(0xFFba0dab),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );

  //Add providers here
  final providers = <SingleChildWidget>[
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => CategoryProvider()),
    ChangeNotifierProvider(create: (context) => FabProvider()),
    ChangeNotifierProvider(create: (context) => LoadingProvider()),
    ChangeNotifierProvider(create: (context) => NotesProvider()),
  ];

  Routes() {
    runApp(MultiProvider(
      providers: providers,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', "US"),
          const Locale('pt', "BR"),
        ],
        debugShowCheckedModeBanner: false,
        title: "Lyst",
        routes: routes,
        initialRoute: SplashScreen.routeName,
        theme: appTheme,
        builder: (context, child) => I18n(child: child),
      ),
    ));
  }
}
