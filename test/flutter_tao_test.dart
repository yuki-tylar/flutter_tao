import 'package:flutter/material.dart';
import 'package:flutter_tao/flutter_tao_route.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tao/flutter_tao_router.dart';

void main() {
  var router = TaoRouter({
    TaoRoute('/', onBuild: (_) => Container()),
    TaoRoute('/route1', onBuild: (_) => Container()),
    TaoRoute('/route1/route2', onBuild: (_) => Container(), exactMatch: false),
    TaoRoute('/route1/:id', onBuild: (args) => Container()),
  });

  test('generate route without pathname', () {
    var setting = const RouteSettings(name: null);
    var res = router.generate(setting);
    expect(res, null);
  });

  test('generate route with empty pathname', () {
    var setting = const RouteSettings(name: '');
    var res = router.generate(setting);
    expect(res, null);
  });

  test('generate route with /', () {
    var setting = const RouteSettings(name: '/');
    var res = router.generate(setting);
    expect(res?.settings.name, '/');
  });

  test('generate route with /route1/route2', () {
    var setting = const RouteSettings(name: '/route1/route2');
    var res = router.generate(setting);
    expect(res?.settings.name, '/route1/route2');
  });

  //test for exactMatch = false.
  //should have route because the route is matched partially with '/route1/route2'
  test('generate route with /route1/route2/route3', () {
    var setting = const RouteSettings(name: '/route1/route2/route3');
    var res = router.generate(setting);
    expect(res?.settings.name, '/route1/route2/route3');
  });

  test('generate route with /route1/:id', () {
    var setting = const RouteSettings(name: '/route1/this-is-test');
    var res = router.generate(setting);
    expect(res?.settings.name, '/route1/this-is-test');
  });
}
