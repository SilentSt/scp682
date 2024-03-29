import 'dart:async';
import 'dart:convert';

import 'package:battery/battery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:scp682/controllers/map_controllers.dart';
import 'package:scp682/controllers/text_controllers.dart';
import 'package:scp682/data/user.dart';
import 'package:scp682/models/models.dart';
import 'package:scp682/requests/send_map_data.dart';
import 'package:scp682/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

///test Marker
///CustomMarker("Карина", 'https://w7.pngwing.com/pngs/49/613/png-transparent-computer-icons-avatar-user-profile-avatar-heroes-dark-black.png', LatLng(47.2313, 39.7233), "10")

/// test PolyLine
///CustomPolyLine([LatLng(47.2313, 39.7233), LatLng(47.2, 39.5)], Colors.red)

/// test Polugon
///CustomPolygon([LatLng(47.2313, 39.7230),LatLng(47.2310, 39.7233),LatLng(47.2318, 39.7233),LatLng(47.2313, 39.7239)], Colors.red)

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  Location? location;
  List<FamilyUser>? famUserList;
  List<Marker>? markersForDrawing;
  var curLocation = LatLng(47.2313, 39.7233);
  Marker myMarker =
      Marker(point: LatLng(47.2313, 39.7233), builder: (context) => const Text("Карина"), width: 50, height: 50);
  static MarkerLayer? myMarkerLayer;

  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      //print("Backgroun working!");

      return Future.value(true);
    });
  }

  @override
  void initState() {
    myMarkerLayer = MarkerLayer(markers: [myMarker]);
    famUserList = [];
    getCurrentLocation();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    //print(state.toString());
    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        // widget is resumed
        break;
      case AppLifecycleState.inactive:
        // widget is inactive
        break;
      case AppLifecycleState.paused:
        // widget is paused
        break;
      case AppLifecycleState.detached:
        // widget is detached
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: curLocation,
                zoom: 18.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/whiskas44/ckwj7lmmx5hb515p7qs85e9xj/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoid2hpc2thczQ0IiwiYSI6ImNrd2o3NDh6cjB6d2cydG1kOHo4ajR0aGUifQ.QkzWmwXq4DWNCBX32pwPQg",
                  // ignore: prefer_const_literals_to_create_immutables
                  additionalOptions: {
                    "accessToken":
                        "pk.eyJ1Ijoid2hpc2thczQ0IiwiYSI6ImNrd2o3NDh6cjB6d2cydG1kOHo4ajR0aGUifQ.QkzWmwXq4DWNCBX32pwPQg",
                    "id": "mapbox.mapbox-streets-v8"
                  },
                ),
                myMarkerLayer!,
                MarkerLayer(markers: markersForDrawing ?? []),
                PolygonLayer(polygons: setPolygons([])),
                PolylineLayer(polylines: setPolyLines([]))
              ],
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(onPressed: () {
                  mapController.move(curLocation, 15);
                })),
          ],
        ),
        bottomNavigationBar: const CustomBottomBar(),
      ),
    );
  }

  List<Marker> setMarkers(List<CustomMarker> markers) {
    List<Marker> tempMarkers = [];
    for (var marker in markers) {
      Marker tempMarker = Marker(
          point: marker.latLng,
          height: 200,
          width: 200,
          builder: (context) => PersonMarker(
                img: marker.img,
                userName: marker.userName,
                battery: marker.batteryPercent,
              ));
      tempMarkers.add(tempMarker);
    }
    return tempMarkers;
  }

  List<Polygon> setPolygons(List<CustomPolygon> polygons) {
    List<Polygon> tempPolygons = [];
    for (var polygon in polygons) {
      Polygon tempPolygon = Polygon(points: polygon.points, color: polygon.color);
      tempPolygons.add(tempPolygon);
    }
    return tempPolygons;
  }

  List<Polyline> setPolyLines(List<CustomPolyLine> polyLines) {
    List<Polyline> tempPolyLines = [];
    for (var polyLine in polyLines) {
      Polyline tempPolyline = Polyline(points: polyLine.points, color: polyLine.color);
      tempPolyLines.add(tempPolyline);
    }
    return tempPolyLines;
  }

  void getCurrentLocation() async {
    location = Location();
    location!.enableBackgroundMode(enable: true);
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location!.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location!.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location!.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location!.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    var res = await getFamily(phoneController.text);
    SharedPreferences sh = await SharedPreferences.getInstance();
    User.familyID = sh.getString('familyID');
    List<dynamic> resList = jsonDecode(res.body);
    for (var res in resList) {
      Map<String, dynamic> tempRes = res!;
      FamilyUser familyUser = FamilyUser(tempRes['name'], tempRes['phone'], tempRes['image']);
      famUserList!.add(familyUser);
    }

    location!.onLocationChanged.listen((newLocation) {
      Timer(const Duration(seconds: 5), () async {
        //updateMyMarker(LatLng(newLocation.latitude!, newLocation.longitude!));
        Map<String, dynamic> data = {};
        data['phone'] = phoneController.text;
        data['latitude'] = newLocation.latitude!;
        data['longitude'] = newLocation.longitude!;
        var battery = Battery();
        data['battery'] = await battery.batteryLevel;
        var resultCoordinates = ((await getCoor(data)) as http.Response).body;
        List<dynamic> usersList = jsonDecode(resultCoordinates);
        List<CustomMarker> markers = [];
        for (var element in usersList) {
          Map<String, dynamic> elm = element;
          var phoneKey = elm['Phone'];
          //var img = Image.memory();
          Map<String, dynamic> point = elm['point'];
          CustomMarker customMarker = CustomMarker(elm['Name'], Image.asset('imgs/camera.png'),
              LatLng(point['Latitude'], point['Longitude']), point['Battery'].toString());
          markers.add(customMarker);
        }
        setState(() {
          //markers.clear();
          markersForDrawing = setMarkers(markers);
        });
        //var res = r as http.Response;
        // print("Получено:\n");
        // print(markers.length);
        // print(resultCoordinates);
        // print("Получено:\n");
        //debugPrint(res.body);
      });
    });
    _locationData = await location!.getLocation();

    //updateMyMarker(LatLng(_locationData.latitude!, _locationData.longitude!));
  }
}

class FamilyUser {
  String phone;
  String name;
  String photo;

  FamilyUser(this.name, this.phone, this.photo);
}
