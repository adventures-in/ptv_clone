import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ptv_api_client/model/v3_departure.dart';
import 'package:ptv_api_client/model/v3_stop_geosearch.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/redux/actions.dart';
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
        title: Text("Second Route"),
      ),
      body: StoreConnector<AppState, BuiltMap<int, BuiltList<V3Departure>>>(
        converter: (store) => store.state.departuresByRoute,
        builder: (context, departuresByRoute) {
          return ListView.builder(
              itemCount: departuresByRoute.keys.length,
              itemBuilder: (context, index) {
                final departure =
                    departuresByRoute[departuresByRoute.keys.elementAt(index)]
                        .first;
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: ListTile(
                          leading: RouteIcon(stop.routeType),
                          title: Text(
                              'routeId: ${departure.routeId} : ${departure.directionId}'),
                          subtitle: Text(
                              'departs at ${departure.scheduledDepartureUtc.toIso8601String()}'),
                          onTap: () {
                            StoreProvider.of<AppState>(context).dispatch(
                                ActionStoreNamedRoute(routeName: 'second'));
                            Navigator.pushNamed(context, '/second',
                                arguments: stop);
                          }),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
