import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ptv_api_client/api.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/models/location.dart';
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
                  ActionSetHome(index: 0),
                );
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
                StoreProvider.of<AppState>(context).dispatch(
                  ActionSetHome(index: 1),
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
      converter: (store) => store.state.stopsByDistance,
      builder: (context, stopsResponse) {
        return ListView.builder(
          itemCount: stopsResponse.stops.length,
          itemBuilder: (context, index) => ListTile(
            leading: Text(stopsResponse.stops[index].stopName),
          ),
        );
      },
    ));
  }
}
