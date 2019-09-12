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
  RouteIcon(
    this.routeType, {
    Key key,
  }) : super(key: key);

  final int routeType;
  static const double radius = 30.0;

  final Map<num, Container> map = {
    0: Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.train, color: Colors.white),
    ),
    1: Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.tram, color: Colors.white),
    ),
    2: Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.directions_bus, color: Colors.white),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return map[routeType];
  }
}
