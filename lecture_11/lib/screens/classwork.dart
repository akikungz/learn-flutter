import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyClassWork extends StatefulWidget {
  const MyClassWork({super.key});

  @override
  State<MyClassWork> createState() => _MyClassWorkState();
}

class _MyClassWorkState extends State<MyClassWork> {
  late GoogleMapController controller;

  final LatLng _center = LatLng(14.1614459, 101.3454897);
  final Set<Marker> _markers = <Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    // _addMarker(_center, "Center");

    _addMarker(LatLng(14.1653722, 101.3454344), 'หอพักชาย');
    _addMarker(LatLng(14.1654245, 101.3391569), 'สนามบิน มจพ.ปราจีนบุรี');
    _addMarker(LatLng(14.1574687, 101.3491784), 'คณะอุตสาหกรรมเกษตรดิจิทัล');
  }

  void _addMarker(LatLng latlng, String id) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(id),
          position: latlng,
          infoWindow: InfoWindow(title: id),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
        backgroundColor: Colors.blue[700],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _center, zoom: 14),
        onMapCreated: _onMapCreated,
        markers: _markers,
        mapType: MapType.satellite,
      ),
    );
  }
}
