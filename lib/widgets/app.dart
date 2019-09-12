import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ptv_api_client/api.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:ptv_clone/widgets/shared.dart';
import 'package:ptv_clone/widgets/stop_departures.dart';
import 'package:redux/redux.dart';

class MyApp extends StatelessWidget {
  MyApp(this.store);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    store.dispatch(const ActionObserveLocation());
    store.dispatch(const ActionGetRoutes());

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'PTV Clone',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyScaffold(),
          '/stop_departures': (context) => StopDeparturesList(),
        },
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PTV Clone'),
      ),
      body: StoreConnector<AppState, int>(
        converter: (store) => store.state.homeIndex,
        builder: (context, index) => IndexedStack(
          index: index,
          children: <Widget>[
            NearbyStopsList(),
            Center(
              child: Text('My Other Page!'),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
                StoreProvider.of<AppState>(context).dispatch(
                  ActionStoreHome(index: 0),
                );
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
                StoreProvider.of<AppState>(context).dispatch(
                  ActionStoreHome(index: 1),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NearbyStopsList extends StatelessWidget {
  const NearbyStopsList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, V3StopsByDistanceResponse>(
      converter: (store) => store.state.nearbyStops,
      builder: (context, stopsResponse) {
        return ListView.builder(
            itemCount: stopsResponse.stops.length,
            itemBuilder: (context, index) {
              var stop = stopsResponse.stops[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: ListTile(
                        leading: RouteIcon(stop.routeType),
                        title: Text(stop.stopName),
                        subtitle: Text(
                            '${routeNames[stop.routeType]} in ${stop.stopSuburb}'),
                        onTap: () {
                          StoreProvider.of<AppState>(context).dispatch(
                              ActionStoreNamedRoute(routeName: 'second'));
                          StoreProvider.of<AppState>(context).dispatch(
                              ActionGetDepartures(
                                  stopId: stop.stopId,
                                  routeType: stop.routeType));
                          Navigator.pushNamed(
                              context, StopDeparturesList.routeName,
                              arguments: stop);
                        }),
                  ),
                ),
              );
            });
      },
    );
  }
}
