library tao;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tao/flutter_tao_route.dart';

class TaoRouter {
  final Set<TaoRoute> routes;
  final TaoRoute? errorRoute;

  TaoRouter(
    this.routes, {
    this.errorRoute,
  });

  Route<dynamic>? generate(RouteSettings setting) {
    if (setting.name == null || setting.name!.isEmpty) {
      return errorRoute?.pageRoute(setting);
    }

    var route =
        routes.firstWhereOrNull((route) => route.comparePath(setting.name!));

    if (route != null) {
      return route.pageRoute(setting);
    }
    return errorRoute?.pageRoute(setting);
  }
}
