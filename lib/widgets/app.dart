import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ptv_clone/models/built_app_state.dart';
import 'package:ptv_clone/models/built_location.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:redux/redux.dart';

class MyApp extends StatelessWidget {
  MyApp(this.store);

  final Store store;

  @override
  Widget build(BuildContext context) {
    store.dispatch(const ActionObserveLocation());

    return StoreProvider<BuiltAppState>(
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
      body: StoreConnector<BuiltAppState, int>(
        converter: (store) => store.state.homeIndex,
        builder: (context, index) => IndexedStack(
          index: index,
          children: <Widget>[
            Center(
                child: StoreConnector<BuiltAppState, BuiltLocation>(
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
                StoreProvider.of<BuiltAppState>(context).dispatch(
                  ActionSetHome(index: 0),
                );
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
                StoreProvider.of<BuiltAppState>(context).dispatch(
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
