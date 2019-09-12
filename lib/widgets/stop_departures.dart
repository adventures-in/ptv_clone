import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ptv_api_client/api.dart';
import 'package:ptv_api_client/model/v3_departure.dart';
import 'package:ptv_api_client/model/v3_stop_geosearch.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/widgets/shared.dart';

class StopDeparturesList extends StatelessWidget {
  const StopDeparturesList({
    Key key,
  }) : super(key: key);

  static const routeName = '/stop_departures';

  @override
  Widget build(BuildContext context) {
    final V3StopGeosearch stop =
        ModalRoute.of(context).settings.arguments as V3StopGeosearch;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.star_border,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.black45,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(stop.stopName,
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          StoreConnector<AppState, BuiltMap<int, BuiltList<V3Departure>>>(
            converter: (store) => store.state.departuresByRoute,
            builder: (context, departuresByRoute) {
              return Expanded(
                child: ListView.builder(
                    itemCount: departuresByRoute.keys.length,
                    itemBuilder: (context, index) {
                      V3Departure nextDeparture;
                      final nowTime = DateTime.now();
                      for (V3Departure departure in departuresByRoute[
                          departuresByRoute.keys.elementAt(index)]) {
                        if (departure.scheduledDepartureUtc.isAfter(nowTime)) {
                          nextDeparture = departure;
                          break;
                        }
                      }
                      final DateTime scheduledLocalTime =
                          nextDeparture.scheduledDepartureUtc.toLocal();
                      final amPm = (scheduledLocalTime.hour < 12) ? 'am' : 'pm';

                      Duration duration;
                      if (nextDeparture.estimatedDepartureUtc != null) {
                        duration = nowTime
                            .difference(nextDeparture.estimatedDepartureUtc);
                      } else {
                        duration = nextDeparture.scheduledDepartureUtc
                            .difference(nowTime);
                      }

                      V3RouteWithStatus route =
                          StoreProvider.of<AppState>(context)
                              .state
                              .routesById[nextDeparture.routeId];

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: ListTile(
                              leading: Column(children: <Widget>[
                                RouteIcon(stop.routeType),
                                Text(route.routeNumber)
                              ]),
                              title: Text(
                                  '${scheduledLocalTime.hour}:${scheduledLocalTime.minute} $amPm to '),
                              subtitle: Text('${route.routeName}'),
                              onTap: () {
                                // StoreProvider.of<AppState>(context).dispatch(
                                //     ActionStoreNamedRoute(routeName: 'second'));
                                // Navigator.pushNamed(context, '/second',
                                //     arguments: stop);
                              },
                              trailing: FlatButton(
                                color: Colors.orange,
                                textColor: Colors.white,
                                padding: EdgeInsets.all(8.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                onPressed: () {},
                                child: Text(
                                  '${duration.inMinutes}', //
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
