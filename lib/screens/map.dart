import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class FullMap extends StatefulWidget {

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {

  var lat=34.729;
  var lan=36.713;
  Future<void> launchGoogleMaps() async {
    double destinationLatitude= lat;
    double destinationLongitude = lan;
    final uri = Uri(
        scheme: "google.navigation",
        // host: '"0,0"',  {here we can put host}
        queryParameters: {
          'q': '$destinationLatitude, $destinationLongitude'
        });
    if (await canLaunchUrl(uri)) {
      try{
        await launchUrl(uri);}catch(e){print(e);}
    } else {
      debugPrint('An error occurred');
    }
  }
  @override
  Widget build(BuildContext context) {
    final m=ModalRoute.of(context)!.settings.arguments as List;
    lat=m[0];
    lan=m[1];
    return Scaffold(
      floatingActionButton: ElevatedButton(onPressed: () {
        print(m);
        launchGoogleMaps();
      }, child: Text('get navigation')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(lat, lan),
          initialZoom: 15,
          keepAlive: true,
          maxZoom: 20,

          // center:
          // center: LatLng(39.920740, 32.854072),
          // zoom: 5,
        ),
        children: [
          TileLayer(
            keepBuffer: 2,
            urlTemplate:'https://api.mapbox.com/styles/v1/numa-alset/clev5io7700hc01o9ke9igzxg/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibnVtYS1hbHNldCIsImEiOiJjbGVjcDd6ZnowMDBpM3hxZzM4OXZvbGJsIn0.QNIfheTCWHbb0K6ZAKIVsw'
            ,maxZoom: 20,
            maxNativeZoom: 20,
            retinaMode: false,

          ),
          MarkerLayer(markers: [
            Marker(point: LatLng(lat, lan), child: Icon(Icons.location_on,color: Colors.blue,size: 40,weight: 20,grade: 10,shadows: [Shadow(color: Colors.blueAccent,blurRadius: 2 )],),)
          ]),

        ],
      ),
    );
  }
}