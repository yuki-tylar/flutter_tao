import 'package:flutter/material.dart';

typedef OnBuild = Widget Function(Map arguments);

class TaoRoute {
  final String path;
  final OnBuild onBuild;
  final bool exactMatch;

  bool comparePath(String to) {
    if (path == to) {
      return true;
    }

    var a0 = to.split('/');
    var a1 = path.split('/');

    if (a0.length < a1.length) {
      return false;
    } else if (exactMatch && a0.length > a1.length) {
      return false;
    }

    var matched = true;
    for (var i = 0; i < a1.length; i++) {
      var s0 = a0[i];
      var s1 = a1[i];

      if (s0 != s1 && (s1.isEmpty || s1[0] != ':')) {
        matched = false;
        break;
      }
    }
    return matched;
  }

  Map getArguments(RouteSettings settings) {
    Map args = {};
    if (settings.name != null && settings.name!.isNotEmpty) {
      var a0 = settings.name!.split('/');
      var a1 = path.split('/');
      for (var i = 0; i < a1.length; i++) {
        var s1 = a1[i];
        if (s1.isNotEmpty && s1[0] == ':') {
          args[s1.substring(1)] = a0[i];
        }
      }
    }
    return args;
  }

  MaterialPageRoute pageRoute(RouteSettings settings) => MaterialPageRoute(
        builder: (_) => onBuild(getArguments(settings)),
        settings: settings,
      );

  TaoRoute(
    this.path, {
    required this.onBuild,
    this.exactMatch = true,
  });
}
