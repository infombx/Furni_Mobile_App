import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final MapController _mapController = MapController();

  // marker storage
  final List<Marker> _markers = [];


  // Initial center → Mauritius (Port Louis)
  final LatLng _initialCenter = LatLng(-20.1619, 57.5013);

  @override
  void initState() {
    super.initState();

    // Add default Mauritius marker
    _markers.add(
      Marker(
        width: 50,
        height: 50,
        point: LatLng(-20.1619, 57.5013),
        child: const Icon(Icons.location_on, size: 36, color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        )
            ,
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _initialCenter,
            initialZoom: 14,
           
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.yourapp',
            ),
            MarkerLayer(markers: _markers),
          ],
        ),
    );
  }
}
