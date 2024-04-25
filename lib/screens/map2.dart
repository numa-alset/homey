import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'dart:async';
// we import our plugin
import 'package:navigation_with_mapbox/navigation_with_mapbox.dart';

class MyApp extends StatefulWidget {
final originLat;
final originLan;
// final desLat;
// final desLat;
  MyApp(this.originLat,this.originLan);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Only android
  final _navigationWithMapboxPlugin = NavigationWithMapbox();
  // Variable for Navigation Map Options
  MapboxOptions? _options;
  // Variables Stream to listen for events
  late Stream<int> listenEvents;
  late StreamSubscription _statusViewSubscription;
  // Control variable for map widget
  bool _controlView = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _options?.style='https://api.mapbox.com/styles/v1/numa-alset/clev5io7700hc01o9ke9igzxg.html?title=view&access_token=pk.eyJ1IjoibnVtYS1hbHNldCIsImEiOiJjbGVjcDd6ZnowMDBpM3hxZzM4OXZvbGJsIn0.QNIfheTCWHbb0K6ZAKIVsw&zoomwheel=true&fresh=true#17.2/34.508687/36.577473/-22';
    // we instantiate the stream getStateMapboxView IOS
    listenEvents = MapboxNavigationView.getStateMapboxView;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Flexible(
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: io.Platform.isAndroid
                                ? () async {
                              // start navigation
                              await _navigationWithMapboxPlugin
                                  .startNavigation(
                                // origin refers to the user's starting point at the time of starting the navigation
                                origin: WayPoint(
                                    latitude: widget.originLat,
                                    longitude: widget.originLan),
                                // destination refers to the end point or goal for the user at the time of starting the navigation
                                destination: WayPoint(
                                    latitude: widget.originLat+0.003,
                                    longitude: widget.originLan+0.002),
                                // if we enable this option we can choose a destination with a sustained tap
                                setDestinationWithLongTap: false,
                                // if we enable this option we will activate the simulation of the route
                                simulateRoute: true,
                                // if we enable this option we can see alternative routes when starting the navigation map ONLY ANDROID
                                // optional, default: false
                                alternativeRoute: true,
                                // the style or theme with which the navigation map will be loaded
                                // optional, default: streets, others: dark, light, traffic_day, traffic_night, satellite, satellite_streets, outdoors
                                language: 'en',
                                // refers to the navigation mode, the route and time will be calculated depending on this
                                // optional, default: driving, others: walking, cycling
                                profile: 'driving',
                                // unit of measure in which the navigation assistant will speak to us
                                // optional, default: metric
                                voiceUnits: 'imperial',
                                // optional, message that will be displayed when starting the navigation map ONLY ANDROID
                                msg:
                                'good',
                                style:
                                'https://api.mapbox.com/styles/v1/numa-alset/clev5io7700hc01o9ke9igzxg.html?title=view&access_token=pk.eyJ1IjoibnVtYS1hbHNldCIsImEiOiJjbGVjcDd6ZnowMDBpM3hxZzM4OXZvbGJsIn0.QNIfheTCWHbb0K6ZAKIVsw&zoomwheel=true&fresh=true#17.2/34.508687/36.577473/-22',
                              );

                            }
                                : null,
                            child: const Text('Start Navigation Android'),
                          ),
                          ElevatedButton(
                            onPressed: io.Platform.isIOS
                                ? () {
                              // we set the map options
                              var options = MapboxOptions(
                                // origin refers to the user's starting point at the time of starting the navigation
                                origin: WayPoint(
                                    latitude: 4.809432,
                                    longitude: -75.700660),
                                // destination refers to the end point or goal for the user at the time of starting the navigation
                                destination: WayPoint(
                                    latitude: 4.759335,
                                    longitude: -75.923914),
                                // if we enable this option we can choose a destination with a sustained tap
                                setDestinationWithLongTap: true,
                                // if we enable this option we will activate the simulation of the route
                                simulateRoute: false,
                                // optional, default: en
                                language: 'es',
                                // optional, default: drivingWithTraffic, others: driving, walking, cycling
                                profile: 'drivingWithTraffic',
                                // optional, default: streets, others: dark, light
                                style: 'dark',
                                // optional, default: metric
                                voiceUnits: 'imperial',
                              );
                              // we save the options and go on to show the map view
                              setState(() {
                                _options = options;
                                _controlView = true;
                              });
                              // we start listening to the state of the map view
                              _statusViewSubscription =
                                  listenEvents.listen(_statusView);
                            }
                                : null,
                            child: const Text('Start Navigation Ios'),
                          ),
                        ],
                      ),
                    ),
                    // When the condition is met we show the navigation map with mapbox
                    if (_controlView)
                      MapboxNavigationView(mapboxOptions: _options!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // function that listens to the state of the map
  _statusView(event) {
    // when we close the map we go to hide the view of the map and stop listening to its state
    if (event == 2) {
      // we hide the map view
      setState(() {
        _controlView = false;
      });
      // we stopped listening to the state of the map
      _statusViewSubscription.cancel();
    }
  }
}