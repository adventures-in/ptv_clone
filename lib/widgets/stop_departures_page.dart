import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ptv_api_client/api.dart';
import 'package:ptv_api_client/model/v3_stop_geosearch.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/widgets/shared.dart';

class StopDeparturesPage extends StatelessWidget {
  const StopDeparturesPage({
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
          StoreConnector<AppState, V3DeparturesResponse>(
            converter: (store) => store.state.stopDepartures,
            builder: (context, response) {
              return Expanded(
                child: ListView.builder(
                    itemCount: response.departures.length,
                    itemBuilder: (context, index) {
                      final departure = response.departures.elementAt(index);
                      final route =
                          response.routes[departure.routeId.toString()];
                      // final

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: ListTile(
                              leading: Column(children: <Widget>[
                                RouteIcon(stop.routeType),
                                Text('${route.routeNumber}')
                              ]),
                              title: Text('time to '),
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
                                  'time',
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
