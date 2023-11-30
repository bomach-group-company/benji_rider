import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDirection extends StatefulWidget {
  // @override
  // State<MapDirection> createState() => MapDirectionState();

  const MapDirection({super.key});

  @override
  State<MapDirection> createState() => MapDirectionState();
}

class MapDirectionState extends State<MapDirection> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Polyline> _polylines = {};

  static const LatLng _start =
      LatLng(37.7749, -122.4194); // Replace with your start coordinates
  static const LatLng _end =
      LatLng(37.7749, -122.4294); // Replace with your end coordinates

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Polyline Example'),
      ),
      body: GoogleMap(
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _addPolyline();
        },
        initialCameraPosition: const CameraPosition(
          target: _start,
          zoom: 15.0,
        ),
      ),
    );
  }

  void _addPolyline() {
    PolylineId id = const PolylineId('polyline');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: const [_start, _end], // List of coordinates to draw the line
      width: 3,
    );
    setState(() {
      _polylines.add(polyline);
    });
  }
}
