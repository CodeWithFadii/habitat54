import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class ShowMap extends StatefulWidget {
  final String cityName;

  const ShowMap({super.key, required this.cityName});

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  ValueNotifier<LatLng> locationNotifier =
      ValueNotifier<LatLng>(const LatLng(25.4052, 55.5136)); // Default location

  @override
  void initState() {
    super.initState();
    searchCity(widget.cityName);
  }

  @override
  void didUpdateWidget(covariant ShowMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cityName != widget.cityName) {
      searchCity(widget.cityName);
    }
  }

  // Function to get coordinates from city name
  Future<void> searchCity(String city) async {
    if (city.isEmpty) {
      return;
    }

    try {
      List<Location> locations = await locationFromAddress(city);
      if (locations.isNotEmpty) {
        LatLng newLocation =
            LatLng(locations[0].latitude, locations[0].longitude);
        locationNotifier.value = newLocation;
      } else {
     
      }
    // ignore: empty_catches
    } catch (e) {
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<LatLng>(
        valueListenable: locationNotifier,
        builder: (context, location, child) {
          return FlutterMap(
            options: MapOptions(
              initialCenter: location,
              onPositionChanged: (camera, hasGesture) {},
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: location,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
