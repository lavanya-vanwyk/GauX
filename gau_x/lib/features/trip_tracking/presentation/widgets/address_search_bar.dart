import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../booking/domain/entities/place_suggestion.dart';
import '../../../booking/presentation/state/booking_notifier.dart';
import '../../../booking/presentation/widgets/booking_feedback.dart';
import '../state/simulation_controller.dart';

class AddressSearchBar extends StatefulWidget {
  const AddressSearchBar({super.key});

  @override
  State<AddressSearchBar> createState() => _AddressSearchBarState();
}

class _AddressSearchBarState extends State<AddressSearchBar> {
  final TextEditingController _controller = TextEditingController();

  Timer? _debounce;
  List<PlaceSuggestion> _suggestions = [];
  bool _isSearching = false;

  // Mock quick locations for MVP
  static const _quickLocations = [
    (
      icon: Icons.home,
      place: PlaceSuggestion(name: 'Home', location: LatLng(-25.7479, 28.1890)),
    ),
    (
      icon: Icons.school,
      place: PlaceSuggestion(
        name: 'School (WeThinkCode_)',
        location: LatLng(-25.7538, 28.1887),
      ),
    ),
    (
      icon: Icons.work,
      place: PlaceSuggestion(
        name: 'Work (IBM Building)',
        location: LatLng(-26.1117, 28.0571),
      ),
    ),
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
      if (!mounted) return;
      setState(() => _isSearching = true);

      final results = await context.read<BookingNotifier>().suggestPlaces(
        query,
      );

      if (mounted) {
        setState(() {
          _suggestions = results;
          _isSearching = false;
        });
      }
    });
  }

  Future<void> _selectSuggestion(
    BuildContext context,
    PlaceSuggestion suggestion,
  ) async {
    FocusScope.of(context).unfocus();
    _controller.clear();
    setState(() => _suggestions = []);

    final result = await context.read<BookingNotifier>().setDestination(
      suggestion.location,
    );

    if (context.mounted) showBookingFeedback(context, result);
  }

  Future<void> _submitSearch(BuildContext context, String query) async {
    if (query.trim().isEmpty) return;
    FocusScope.of(context).unfocus();

    final result = await context
        .read<BookingNotifier>()
        .searchAndSetDestination(query);

    if (!context.mounted) return;

    // Keep the text on errors so the rider can correct it or retry
    if (result case BookingResult.success || BookingResult.outsideGeofence) {
      _controller.clear();
    }
    showBookingFeedback(context, result);
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
                    offset: Offset(0, 4),
                  ),
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
                                  color: AppColors.gautrainGold,
                                ),
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
                            location.icon,
                            color: AppColors.gautrainGold,
                            size: 16,
                          ),
                          label: Text(
                            location.place.name.split(' ').first,
                            style: const TextStyle(
                              color: AppColors.gautrainNavy,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () =>
                              _selectSuggestion(context, location.place),
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
                      offset: Offset(0, 4),
                    ),
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
                      leading: const Icon(
                        Icons.location_on,
                        color: AppColors.gautrainGold,
                      ),
                      title: Text(
                        suggestion.name,
                        style: const TextStyle(
                          color: AppColors.gautrainNavy,
                          fontSize: 14,
                        ),
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
