import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lystui/providers/auth.provider.dart';
import 'package:lystui/providers/env.provider.dart';
import 'package:lystui/screens/categories/categories.screen.dart';
import 'package:lystui/screens/home/home.screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'models/destination.model.dart';

class Routes {
  final isDev;

  //Declare main app routes
  final routes = <String, WidgetBuilder>{
    HomeScreen.routeName: (context) => HomeScreen(),
  };

  // Declare bottom navigation nested routes
  static final subRoutes = <Destination>[
    Destination(
      title: "Home",
      icon: Icons.home,
      routes: [CategoriesScreen()],
    ),
    Destination(
      title: "Settings",
      icon: Icons.shopping_cart,
      child: Center(child: Text('Settings')),
    )
  ];

  final appTheme = ThemeData(
    primaryColor: Color(0xFFba0dab),
  );

  final providers = <SingleChildWidget>[
    ChangeNotifierProvider(create: (context) => AuthProvider()),
  ];

  Routes({this.isDev}) {
    providers.add(
        ChangeNotifierProvider(create: (context) => EnvProvider(isDev: isDev)));

    runApp(MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Lyst",
        routes: routes,
        initialRoute: HomeScreen.routeName,
        theme: appTheme,
      ),
    ));
  }
}
