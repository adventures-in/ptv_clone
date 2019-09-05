import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ptv_api_client/api.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:redux/redux.dart';

class MyApp extends StatelessWidget {
  MyApp(this.store);

  final Store store;

  @override
  Widget build(BuildContext context) {
    store.dispatch(const ActionObserveLocation());

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'PTV Clone',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: MyScaffold(),
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
            NearbyStops(),
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

class NearbyStops extends StatelessWidget {
  const NearbyStops({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StoreConnector<AppState, V3StopsByDistanceResponse>(
      converter: (store) => store.state.nearbyStopsResponse,
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
                    ),
                  ),
                ),
              );
            });
      },
    ));
  }
}

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

// this is avaiable in an API call but I can't see it changing
// hardcoding it in for now as this seems like the pragmatic solution
final Map<int, String> routeNames = const {
  0: 'Train',
  1: 'Tram',
  2: 'Bus',
  3: 'Vline',
  4: 'Night Bus'
};
