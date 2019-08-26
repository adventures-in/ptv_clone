import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/models/built_location.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:ptv_clone/redux/middleware.dart';
import 'package:ptv_clone/redux/reducers.dart';
import 'package:ptv_clone/services/api_service.dart';
import 'package:ptv_clone/services/device_service.dart';
import 'package:redux/redux.dart';

void main() {
  final ApiService apiService = ApiService();
  final DeviceService deviceService = DeviceService(Geolocator());

  final Store store = Store<AppState>(
    appStateReducer,
    middleware: createMiddlewares(apiService, deviceService),
    initialState: AppState.initialState(),
  );

  runApp(MyApp(store));
}

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
            Center(
                child: StoreConnector<AppState, BuiltLocation>(
              converter: (store) => store.state.location,
              builder: (context, location) {
                return Text('Location: $location');
              },
            )),
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
