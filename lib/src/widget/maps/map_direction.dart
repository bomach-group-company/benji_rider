// ignore_for_file: unused_field

import 'dart:async';
import 'dart:ui' as ui; // Import the ui library with an alias

import 'package:benji_rider/src/providers/keys.dart';
import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:benji_rider/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../repo/controller/error_controller.dart';

class MapDirection extends StatefulWidget {
  final double latitude;
  final double longitude;
  const MapDirection(
      {super.key, required this.latitude, required this.longitude});

  @override
  State<MapDirection> createState() => _MapDirectionState();
}

class _MapDirectionState extends State<MapDirection> {
  //============================================================== INITIAL STATE ====================================================================\\
  @override
  void initState() {
    super.initState();
    _markerTitle = <String>["Me", "Destination"];
    _markerSnippet = <String>["My Location", "Heading to"];
    destinationLocation = LatLng(widget.latitude, widget.longitude);

    _loadMapData();
  }

  @override
  void dispose() {
    super.dispose();
  }
  //============================================================= ALL VARIABLES ======================================================================\\

  late LatLng destinationLocation;
  LatLng? riderLocation;

  final List<LatLng> _polylineCoordinates = [];

  Uint8List? _markerImage;
  final List<Marker> _markers = <Marker>[];
  final List<MarkerId> _markerId = <MarkerId>[
    const MarkerId("0"),
    const MarkerId("1")
  ];
  List<String>? _markerTitle;
  List<String>? _markerSnippet;
  final List<String> _customMarkers = <String>[
    "assets/icons/delivery_bike.png",
    "assets/icons/person_location.png",
  ];

  //============================================================= BOOL VALUES ======================================================================\\

  //========================================================== GlobalKeys ============================================================\\

  //=================================== CONTROLLERS ======================================================\\
  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? _newGoogleMapController;

  //============================================================== FUNCTIONS ===================================================================\\

  //======================================= Google Maps ================================================\\

  /// When the location services are not enabled or permissions are denied the `Future` will return an error.
  Future<void> _loadMapData() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      ApiProcessorController.errorSnack('Location services are disabled');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        ApiProcessorController.errorSnack(
            'Location permissions are denied, allow in settings');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      ApiProcessorController.errorSnack(
          'Location permissions are denied, allow in settings');
      return;
    }
    await _getUserCurrentLocation();
    await _loadCustomMarkers();
    getPolyPoints();
  }

//============================================== Get Current Location ==================================================\\

  Future<Position> _getUserCurrentLocation() async {
    Position userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    riderLocation = LatLng(userLocation.latitude, userLocation.longitude);

    LatLng latLngPosition =
        LatLng(userLocation.latitude, userLocation.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);

    _newGoogleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );

    return userLocation;
  }

  //====================================== Get bytes from assets =========================================\\

  Future<Uint8List> _getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  //====================================== Get Location Markers =========================================\\

  _loadCustomMarkers() async {
    Position userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    riderLocation = LatLng(userLocation.latitude, userLocation.longitude);

    List<LatLng> latLng = <LatLng>[
      LatLng(userLocation.latitude, userLocation.longitude),
      destinationLocation
    ];
    for (int i = 0; i < _customMarkers.length; i++) {
      final Uint8List markerIcon =
          await _getBytesFromAssets(_customMarkers[i], 100);

      _markers.add(
        Marker(
          markerId: _markerId[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          position: latLng[i],
          infoWindow: InfoWindow(
            title: _markerTitle![i],
            snippet: _markerSnippet![i],
          ),
        ),
      );
      setState(() {});
    }
  }

  //============================================== Adding polypoints ==================================================\\
  void getPolyPoints() async {
    final List<MarkerId> markerId = <MarkerId>[
      const MarkerId("Location"),
      const MarkerId("Destination"),
    ];
    List<String> markerTitle = <String>["Location", "Destination"];

    final List<LatLng> locations = <LatLng>[
      riderLocation!,
      destinationLocation
    ];
    final List<BitmapDescriptor> markers = <BitmapDescriptor>[
      BitmapDescriptor.defaultMarker,
      BitmapDescriptor.defaultMarkerWithHue(8),
    ];

    for (var i = 0; i < markerId.length; i++) {
      _markers.add(
        Marker(
          markerId: markerId[i],
          position: locations[i],
          icon: markers[i],
          visible: true,
          infoWindow: InfoWindow(title: markerTitle[i]),
        ),
      );
    }

    PolylinePoints polyLinePoints = PolylinePoints();
    PolylineResult result = await polyLinePoints.getRouteBetweenCoordinates(
      googleMapsApiKey,
      PointLatLng(riderLocation!.latitude, riderLocation!.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    }
  }

//============================================== Create Google Maps ==================================================\\

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    _newGoogleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    // var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        title: "Map direction",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Container(
          child: riderLocation == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: kAccentColor,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: GoogleMap(
                        mapType: MapType.normal,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: riderLocation!,
                          zoom: 14,
                        ),
                        markers: Set.of(_markers),
                        polylines: {
                          Polyline(
                            polylineId: const PolylineId("Delivery route"),
                            points: _polylineCoordinates,
                            color: kAccentColor,
                            consumeTapEvents: true,
                            geodesic: true,
                            width: 5,
                            visible: true,
                          ),
                        },
                        compassEnabled: true,
                        mapToolbarEnabled: true,
                        minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                        tiltGesturesEnabled: true,
                        zoomGesturesEnabled: false,
                        fortyFiveDegreeImageryEnabled: true,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        cameraTargetBounds: CameraTargetBounds.unbounded,
                        rotateGesturesEnabled: true,
                        scrollGesturesEnabled: true,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
