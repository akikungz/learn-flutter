import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class CurrentMaps extends StatefulWidget {
  const CurrentMaps({super.key});

  @override
  State<CurrentMaps> createState() => _CurrentMapsState();
}

class _CurrentMapsState extends State<CurrentMaps> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  late GoogleMapController controller;
  final Set<Marker> _markers = <Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
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

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1️⃣ Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // If GPS is OFF, ask the user to enable it
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    // 2️⃣ Check location permission status
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // If the user denies again, show an alert
        _showPermissionDeniedDialog();
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // If permissions are permanently denied, direct user to settings
      _showSettingsDialog();
      return Future.error(
        'Location permissions are permanently denied. Please enable them in settings.',
      );
    }

    // 3️⃣ Get the current location
    try {
      Position position = await Geolocator.getCurrentPosition();

      setState(() {
        _currentPosition = position;
      });

      print('Current Position: ${position.latitude}, ${position.longitude}');
      _addMarker(
        LatLng(position.latitude, position.longitude),
        "Current Location",
      );
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  // 🚨 Show Dialog if Permissions are Denied
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Permission Denied"),
            content: Text(
              "This app needs location access to work properly. Please allow location access.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  // 🚨 Show Dialog if Permissions are Permanently Denied
  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Location Permission Needed"),
            content: Text(
              "You have permanently denied location access. Please enable it in settings.",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await Geolocator.openAppSettings();
                  Navigator.pop(context);
                },
                child: Text("Open Settings"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Current Location')),
      body: Expanded(
        child:
            _currentPosition != null
                ? GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentPosition!.latitude,
                      _currentPosition!.longitude,
                    ),
                    zoom: 20,
                  ),
                  onMapCreated: _onMapCreated,
                  markers: _markers,
                  mapType: MapType.satellite,
                )
                : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
