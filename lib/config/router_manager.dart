import 'package:cnode_flutter2/pages/tab/tab_navigator.dart';
import 'package:cnode_flutter2/widgets/page_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteName {
  static const String home = '/';
  static const String login = 'login';
  static const String detail = 'detail';
}
class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return NoAnimateRouteBuilder(TabNavigatorPage());
        break;
      default:
        return CupertinoPageRoute(builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ));
    }
  }
}