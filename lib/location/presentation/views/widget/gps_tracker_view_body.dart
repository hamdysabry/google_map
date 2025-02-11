// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GpsTrackerViewBody extends StatefulWidget {
//   const GpsTrackerViewBody({super.key});

//   @override
//   State<GpsTrackerViewBody> createState() => _GpsTrackerViewBodyState();
// }

// class _GpsTrackerViewBodyState extends State<GpsTrackerViewBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GoogleMap(
//       mapType: MapType.normal,
//       initialCameraPosition: const CameraPosition(
//         target: LatLng(37.7749, -122.4194),
//         zoom: 11,
//       ),
//       onMapCreated: (GoogleMapController controller) {},
//       myLocationButtonEnabled: true,
//       myLocationEnabled: true,
//       zoomControlsEnabled: true,
//     ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GpsTrackerViewBody extends StatefulWidget {
  const GpsTrackerViewBody({super.key});

  @override
  _GpsTrackerViewBodyState createState() => _GpsTrackerViewBodyState();
}

class _GpsTrackerViewBodyState extends State<GpsTrackerViewBody> {
  late GoogleMapController _mapController;
  final Location _locationService = Location();
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _initLocationTracking();
  }

  Future<void> _initLocationTracking() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationService.onLocationChanged.listen((LocationData locationData) {
      setState(() {
        _currentLocation = const LatLng(30.66298, 31.27126);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentLocation!,
                zoom: 15,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: {
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: _currentLocation!,
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
// sdadas