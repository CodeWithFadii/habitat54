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
  LatLng location = const LatLng(23.4241, 53.8478); // Default location

  @override
  void initState() {
    super.initState();
    searchCity(widget
        .cityName); // Search for the city name passed from the previous screen
  }

  // Function to get coordinates from city name
  Future<void> searchCity(String city) async {
    try {
      List<Location> locations = await locationFromAddress(city);
      if (locations.isNotEmpty) {
        LatLng newLocation =
            LatLng(locations[0].latitude, locations[0].longitude);
        setState(() {
          location = newLocation;
        });
        print(locations.toString());
      } else {
        print('City not found');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options:
            MapOptions(initialCenter: location, minZoom: 5.0, maxZoom: 18.0),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            // Plenty of other options available!
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
      ),
    );
  }
}
