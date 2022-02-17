Map<String, String>? getMatchedRouteArgs(
  String original,
  String target,
  bool exactMatch,
) {
  var a0 = original.split('/');
  var a1 = target.split('/');

  if (a0.length < a1.length) {
    return null;
  } else if (exactMatch && a0.length > a1.length) {
    return null;
  }

  Map<String, String> args = {};
  var matched = true;
  for (var i = 0; i < a1.length; i++) {
    var s0 = a0[i];
    var s1 = a1[i];

    if (s0 != s1) {
      if (s1.isNotEmpty && s1[0] == ':') {
        args[s1.substring(1)] = s0;
      } else {
        matched = false;
      }
    }
  }

  return matched ? args : null;
}
