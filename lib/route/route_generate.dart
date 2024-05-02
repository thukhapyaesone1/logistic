import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistic/route/route_list.dart';
import 'package:logistic/ui/pick/barcode_detail_page.dart';
import 'package:logistic/ui/pick/pick_up_location_page.dart';
import 'package:logistic/ui/pick/pick_up_page.dart';

import '../ui/home/home_page.dart';
import '../ui/login_page.dart';

Route<Map<String, dynamic>> generateRoute(RouteSettings routeSettings) {
  print("Route ::::::::: ${routeSettings.name}");
  switch (routeSettings.name) {
    case RouteList.loginPage:
      return _buildPageRoute(routeSettings, const LoginPage());
    case RouteList.mainHomePage:
      return _buildPageRoute(routeSettings, const MainHomePage());
    case RouteList.pickUpPage:
      return _buildPageRoute(routeSettings, const PickUpPage());
    case RouteList.pickUpLocation:
      return _buildPageRoute(routeSettings,  PickUpLocationsPage(isPickUp: true,));
    default:
      return _buildPageRoute(routeSettings, const NotFoundPage());
  }
}

MaterialPageRoute<Map<String, dynamic>> _buildPageRoute(
    RouteSettings routeSettings, Widget page) {
  return MaterialPageRoute<Map<String, dynamic>>(
      builder: (context) => page, settings: routeSettings);
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          Text('Not found Page !'),
        ],
      ),
    );
  }
}
