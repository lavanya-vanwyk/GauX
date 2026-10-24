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

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    if (query.trim().isEmpty) {
      setState(() {
        _suggestions = [];
        _isSearching = false;
      });
      return;
    }

    // Wait 500ms after the user stops typing before making the API call
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

  void _selectSuggestion(BuildContext context, Map<String, dynamic> suggestion) {
    FocusScope.of(context).unfocus(); // Dismiss keyboard
    _controller.clear();
    setState(() => _suggestions = []); // Clear dropdown
    
    final latLng = LatLng(suggestion['lat'], suggestion['lon']);
    context.read<BookingNotifier>().setDestination(latLng);
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SimulationController>(
      builder: (context, simulationController, child) {
        // Hide the search bar entirely if a ride is in progress
        if (simulationController.rideState != RideState.initial) {
          return const SizedBox.shrink();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The Search Input Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))
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
                      decoration: InputDecoration(
                        hintText: 'Where to?',
                        border: InputBorder.none,
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon: _isSearching 
                          ? const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.gautrainGold),
                            ) 
                          : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Suggestions Dropdown
            if (_suggestions.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 8),
                constraints: const BoxConstraints(maxHeight: 250),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
                  ],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: _suggestions.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.lightGrey),
                  itemBuilder: (context, index) {
                    final suggestion = _suggestions[index];
                    return ListTile(
                      leading: const Icon(Icons.location_on, color: AppColors.gautrainGold),
                      title: Text(
                        suggestion['name'],
                        style: const TextStyle(color: AppColors.gautrainNavy, fontSize: 14),
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