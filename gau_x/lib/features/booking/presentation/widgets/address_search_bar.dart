import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/place_suggestion.dart';
import '../state/booking_controller.dart';
import 'booking_feedback.dart';
import 'place_suggestion_list.dart';
import 'quick_location_chips.dart';

/// "Where to?" field with debounced autocomplete and saved-place chips.
class AddressSearchBar extends ConsumerStatefulWidget {
  const AddressSearchBar({super.key});

  @override
  ConsumerState<AddressSearchBar> createState() => _AddressSearchBarState();
}

class _AddressSearchBarState extends ConsumerState<AddressSearchBar> {
  final _controller = TextEditingController();

  Timer? _debounce;
  List<PlaceSuggestion> _suggestions = [];
  bool _isSearching = false;

  BookingController get _booking =>
      ref.read(bookingControllerProvider.notifier);

  void _onSearchChanged(String query) {
    _debounce?.cancel();

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

      final results = await _booking.suggestPlaces(query);

      if (mounted) {
        setState(() {
          _suggestions = results;
          _isSearching = false;
        });
      }
    });
  }

  Future<void> _selectSuggestion(PlaceSuggestion suggestion) async {
    FocusScope.of(context).unfocus();
    _controller.clear();
    setState(() => _suggestions = []);

    final result = await _booking.setDestination(suggestion.location);

    if (mounted) showBookingFeedback(context, result);
  }

  Future<void> _submitSearch(String query) async {
    if (query.trim().isEmpty) return;
    FocusScope.of(context).unfocus();

    final result = await _booking.searchAndSetDestination(query);

    if (!mounted) return;

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
    final media = MediaQuery.of(context);
    final availableHeight = media.size.height - media.viewInsets.bottom - 150;
    final listMaxHeight = availableHeight.clamp(120.0, 350.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SearchField(
          controller: _controller,
          isSearching: _isSearching,
          onChanged: _onSearchChanged,
          onSubmitted: _submitSearch,
        ),
        if (_controller.text.isEmpty && _suggestions.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: QuickLocationChips(onSelected: _selectSuggestion),
          ),
        if (_suggestions.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: PlaceSuggestionList(
              suggestions: _suggestions,
              maxHeight: listMaxHeight,
              onSelected: _selectSuggestion,
            ),
          ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.isSearching,
    required this.onChanged,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final bool isSearching;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                hintText: 'Where to?',
                border: InputBorder.none,
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: isSearching
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
    );
  }
}
