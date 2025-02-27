import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMaps extends StatefulWidget {
  const MyMaps({super.key});

  @override
  State<MyMaps> createState() => _MyMapsState();
}

class _MyMapsState extends State<MyMaps> {
  late GoogleMapController controller;

  final LatLng _center = LatLng(14.158596, 101.345750);
  final Set<Marker> _markers = <Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    _addMarker(_center, "Googleplex");
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
        initialCameraPosition: CameraPosition(target: _center, zoom: 20),
        onMapCreated: _onMapCreated,
        markers: _markers,
        mapType: MapType.satellite,
      ),
    );
  }
}
