import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/network/nominatim_client.dart';
import '../../../booking/presentation/state/booking_notifier.dart';
import '../state/simulation_controller.dart';

class AddressSearchBar extends StatefulWidget {
  const AddressSearchBar({super.key});

  @override
  State<AddressSearchBar> createState() => _AddressSearchBarState();
}

class _AddressSearchBarState extends State<AddressSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final NominatimClient _geocodingClient = NominatimClient();

  Timer? _debounce;
  List<Map<String, dynamic>> _suggestions = [];
  bool _isSearching = false;

  // Mock quick locations for MVP
  final List<Map<String, dynamic>> _quickLocations = [
    {'name': 'Home', 'lat': -25.7479, 'lon': 28.1890},
    {'name': 'School (WeThinkCode_)', 'lat': -25.7538, 'lon': 28.1887},
    {'name': 'Work (IBM Building)', 'lat': -26.1117, 'lon': 28.0571},
  ];

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.trim().isEmpty) {
      setState(() {
        _suggestions = [];
        _isSearching = false;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      setState(() => _isSearching = true);

      final results = await _geocodingClient.fetchSuggestions(query);

      if (mounted) {
        setState(() {
          _suggestions = results;
          _isSearching = false;
        });
      }
    });
  }

  void _showGeofenceDialog(BuildContext context) {
    unawaited(showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.deepNavy,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.security, color: AppColors.gautrainGold, size: 30.0),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Outside Service Area',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
          content: const Text(
            'To ensure fast pickups and maintain our micro-fleet efficiency, GauX vehicles are geo-fenced to a 5km radius around the station.\n\nPlease select a destination closer to the station.',
            style: TextStyle(color: Colors.grey, height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Understood',
                  style: TextStyle(color: AppColors.gautrainGold)),
            ),
          ],
        );
      },
    ));
  }

  Future<void> _selectSuggestion(
      BuildContext context, Map<String, dynamic> suggestion) async {
    FocusScope.of(context).unfocus();
    _controller.clear();
    setState(() => _suggestions = []);

    final latLng = LatLng(suggestion['lat'], suggestion['lon']);

    // Capture the result enum from the Notifier
    final result = await context.read<BookingNotifier>().setDestination(latLng);

    if (context.mounted && result == BookingResult.outsideGeofence) {
      _showGeofenceDialog(context);
    }
  }

  Future<void> _submitSearch(BuildContext context, String query) async {
    if (query.trim().isEmpty) return;
    FocusScope.of(context).unfocus();

    final result =
        await context.read<BookingNotifier>().searchAndSetDestination(query);

    if (!context.mounted) return;

    if (result == BookingResult.outsideGeofence) {
      _controller.clear();
      _showGeofenceDialog(context);
    } else if (result == BookingResult.notFound) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not find that address. Please try again.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } else {
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;
    final double availableHeight = screenHeight - keyboardHeight - 150;
    final double listMaxHeight = availableHeight.clamp(120.0, 350.0);

    return Consumer<SimulationController>(
      builder: (context, simulationController, child) {
        if (simulationController.rideState != RideState.initial) {
          return const SizedBox.shrink();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4)),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: AppColors.gautrainNavy),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: _onSearchChanged,
                      onSubmitted: (value) => _submitSearch(context, value),
                      decoration: InputDecoration(
                        hintText: 'Where to?',
                        border: InputBorder.none,
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon: _isSearching
                            ? const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.gautrainGold),
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Quick Select Chips
            if (_controller.text.isEmpty && _suggestions.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _quickLocations
                      .map(
                        (location) => ActionChip(
                          backgroundColor: AppColors.white,
                          side: const BorderSide(color: AppColors.lightGrey),
                          avatar: Icon(
                            location['name'] == 'Home'
                                ? Icons.home
                                : location['name'].contains('School')
                                    ? Icons.school
                                    : Icons.work,
                            color: AppColors.gautrainGold,
                            size: 16,
                          ),
                          label: Text(
                            location['name'].toString().split(' ').first,
                            style: const TextStyle(
                                color: AppColors.gautrainNavy,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => _selectSuggestion(context, location),
                        ),
                      )
                      .toList(),
                ),
              ),

            if (_suggestions.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 8),
                constraints: BoxConstraints(maxHeight: listMaxHeight),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4)),
                  ],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: _suggestions.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, color: AppColors.lightGrey),
                  itemBuilder: (context, index) {
                    final suggestion = _suggestions[index];
                    return ListTile(
                      leading: const Icon(Icons.location_on,
                          color: AppColors.gautrainGold),
                      title: Text(
                        suggestion['name'],
                        style: const TextStyle(
                            color: AppColors.gautrainNavy, fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => _selectSuggestion(context, suggestion),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
