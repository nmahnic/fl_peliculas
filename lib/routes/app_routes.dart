import '../models/models.dart';
import '../screens/screens.dart';

import 'package:flutter/material.dart';

class AppRoutes {

  static const initialRoute = '/home';
  static final menuOptions = [
    MenuOption( name: 'Details', route: '/details', screen: const DetailsScreen() )
  ];


  static  Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll({'/home': (BuildContext context) => const HomeScreen()});
    
    for (final option in menuOptions) {
      appRoutes.addAll({option.route : (BuildContext context) => option.screen});
    }

    return appRoutes;
  }
}