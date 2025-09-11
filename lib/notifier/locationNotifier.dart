import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucus/models/appLocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

final dummyLocation = AppLocation(
  latitude: 28.6692,
  longitude: 77.4538,
  street: 'Raj Nagar Extension',
  city: 'Ghaziabad',
  state: 'Uttar Pradesh',
  country: 'India',
  pinCode: '201017',
);

class LocationState {
  final AppLocation location;
  final bool isLoading;
  final String? error;

  LocationState({
    AppLocation? location,
    this.isLoading = false,
    this.error,
  }) : location = location ?? dummyLocation;

  LocationState copyWith({
    AppLocation? location,
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
  LocationNotifier() : super(LocationState()) {
    fetchLocation();
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high, distanceFilter: 100),
    );
  }

  Future<void> fetchLocation() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      Position position = await _getCurrentLocation();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      AppLocation appLocation = AppLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        street: place.street ?? '',
        city: place.locality ?? '',
        state: place.administrativeArea ?? '',
        country: place.country ?? '',
        pinCode: place.postalCode ?? '',
      );
      print(appLocation.toJson());
      await Future.delayed(const Duration(seconds: 1)); // Simulate API
      state = state.copyWith(location: appLocation, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final locationNotifier =
    StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  return LocationNotifier();
});
