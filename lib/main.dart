import 'package:flutter/material.dart';
import 'package:newsapp/controllers/home_controller.dart';
import 'package:newsapp/controllers/search_controller.dart';
import 'package:newsapp/controllers/world_controller.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/views/root.dart';
import 'package:provider/provider.dart';

import 'controllers/favorite_controller.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),
    ),
    ChangeNotifierProvider<WorldController>(
      create: (_) => WorldController(),
    ),
    ChangeNotifierProvider<SearchController>(
      create: (_) => SearchController(),
    ),
    ChangeNotifierProvider<FavoriteController>(
      create: (_) => FavoriteController(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      key: navKey!,
      title: 'NewsApp Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: PColors.backgrounColor),
      home: const RootScreen(),
    );
  }
}
