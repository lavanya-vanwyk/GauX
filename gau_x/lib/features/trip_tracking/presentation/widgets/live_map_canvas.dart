FlutterMap(
  mapController: _mapController,
  options: MapOptions(
    initialCenter: _currentLocation.value.latitude == 0
        ? const LatLng(0, 0)
        : _currentLocation.value,
    initialZoom: 16.0,
  ),
  children: [
    TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.walking_companion',
    ),
    if (_routePoints.isNotEmpty)
      PolylineLayer(
        polylines: [
          Polyline(
              points: _routePoints,
              strokeWidth: 5.0,
              color: Colors.blueAccent),
        ],
      ),
    ValueListenableBuilder<LatLng>(
      valueListenable: _currentLocation,
      builder: (context, location, child) {
        return MarkerLayer(
          markers: [
            Marker(
              point: location,
              width: 80,
              height: 80,
              child: const Icon(Icons.person_pin_circle,
                  color: Colors.redAccent, size: 40),
            ),
          ],
        );
      },
    ),
  ],
)

Future<void> _getRoute() async {
  // ... (fetches route)
  if (points.isNotEmpty) {
    _currentLocation.value = points[0];
    _mapController.move(points[0], 15); // Centers on start point
  }
}

void _startDebugWalk() {
  // ...
  _walkTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
    if (_currentRouteIndex >= _routePoints.length - 1) {
      _stopDebugWalk();
      return;
    }
    if (!mounted) return;

    _currentRouteIndex++;
    LatLng newPos = _routePoints[_currentRouteIndex];

    _updateLocation(newPos);
    
    // Automatically pan the camera to track the simulated marker
    _mapController.move(newPos, 16); 
  });
}

void _updateLocation(LatLng newPos) {
  // ...
  _currentLocation.value = newPos;

  // Pans camera if in free-roam mode
  if (widget.isFreeRoam) {
    _mapController.move(newPos, 16);
  }
}