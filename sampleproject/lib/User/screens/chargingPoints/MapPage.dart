import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/APIs/models/chargingPoint.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  double _originLatitude = 32.210353, _originLongitude = 35.249198;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyDCwdiIlu3ZpgHYkPgSpamg-EHktUkhirI";
  List<chargingPointModel> _points = [];

  FetchData _fetchData = FetchData();

  @override
  void initState() {
    super.initState();
    fetchAndDraw();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(_originLatitude, _originLongitude), zoom: 15),
        myLocationEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: _onMapCreated,
        markers: Set<Marker>.of(markers.values),
        polylines: Set<Polyline>.of(polylines.values),
      )),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  List<LatLng> _selectedPoints = [];

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
    );
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.blue, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  // _clearPoyline() {
  //   polylines.clear();
  //   polylineCoordinates.clear();
  //   setState(() {});
  // }

  _getPolyline() async {
    int point1 = 0;
    int point2 = 0;
    while (point2 < _points.length) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleAPiKey,
          PointLatLng(_selectedPoints[point1].latitude,
              _selectedPoints[point1].longitude),
          PointLatLng(_selectedPoints[point2].latitude,
              _selectedPoints[point2].longitude),
          travelMode: TravelMode.driving,
          wayPoints: []);
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      _addPolyLine();
      point1++;
      point2++;
    }
  }

  void fetchAndDraw() async {
    await fetchAllPoints();
    draw();
    _getPolyline();
  }

  void draw() {
    for (final point in _points) {
      _addMarker(LatLng(double.parse(point.lat), double.parse(point.long)),
          "${point.lat} ${point.long}", BitmapDescriptor.defaultMarker);
      _selectedPoints
          .add(LatLng(double.parse(point.lat), double.parse(point.long)));
    }
  }

  Future fetchAllPoints() async {
    var data = await _fetchData.allChargingPoints();
    print("--------------------------------------------");
    setState(() {
      this._points = data;
    });
  }
}
