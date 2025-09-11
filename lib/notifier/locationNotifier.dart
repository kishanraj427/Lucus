import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationState {
  final String location;
  final bool isLoading;
  final String? error;

  const LocationState({
    this.location = 'Delhi, India',
    this.isLoading = false,
    this.error,
  });

  LocationState copyWith({
    String? location,
    bool? isLoading,
    String? error,
  }) {
    return LocationState(
      location: location ?? this.location,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier() : super(const LocationState());

  Future<void> fetchLocation() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Replace with real API or geolocation call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API
      state = state.copyWith(location: 'New York, NY', isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final locationProvider =
    StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  return LocationNotifier();
});
