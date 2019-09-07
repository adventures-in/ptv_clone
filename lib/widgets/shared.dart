// this is avaiable in an API call but I can't see it changing
// hardcoding it in for now as this seems like the pragmatic solution
import 'package:flutter/material.dart';

final Map<int, String> routeNames = const {
  0: 'Train',
  1: 'Tram',
  2: 'Bus',
  3: 'Vline',
  4: 'Night Bus'
};

class RouteIcon extends StatelessWidget {
  const RouteIcon(
    this.routeType, {
    Key key,
  }) : super(key: key);

  final int routeType;
  final Map<int, Icon> map = const {
    0: Icon(Icons.train, color: Colors.red),
    1: Icon(Icons.tram, color: Colors.green),
    2: Icon(Icons.directions_bus, color: Colors.blue)
  };

  @override
  Widget build(BuildContext context) {
    return map[routeType];
  }
}
