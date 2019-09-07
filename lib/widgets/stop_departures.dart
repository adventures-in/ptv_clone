import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ptv_api_client/model/v3_departures_response.dart';
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
    final V3StopGeosearch stop = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: StoreConnector<AppState, V3DeparturesResponse>(
        converter: (store) => store.state.departures,
        builder: (context, departuresResponse) {
          return ListView.builder(
              itemCount: departuresResponse.departures.length,
              itemBuilder: (context, index) {
                final departure = departuresResponse.departures[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: ListTile(
                          leading: RouteIcon(stop.routeType),
                          title: Text(
                              'stop: ${departure.stopId}, direction: ${departure.directionId}'),
                          subtitle: Text(
                              'departs at ${departure.estimatedDepartureUtc}'),
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
