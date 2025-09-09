import 'package:lucus/utility/apiUrl.dart';

import '../models/store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/sessionHandler.dart';

// Mock data
const mockStoreData = [
  Store(
    id: '1',
    name: 'Electronics Store',
    description: 'Your one-stop shop for gadgets.',
    imageUrl: 'https://example.com/electronics.jpg',
    rating: 4.5,
  ),
  Store(
    id: '2',
    name: 'Fashion Hub',
    description: 'Latest trends in clothing.',
    imageUrl: 'https://example.com/fashion.jpg',
    rating: 4.2,
  ),
];

class StoreRepository {
  final SessionHandler _sessionHandler;

  StoreRepository(this._sessionHandler);

  Future<List<Store>> getStores() async {
    try {
      final response = await _sessionHandler.get<List<Store>>(
        ApiUrl.getStores,
        fromJson: (data) => (data as List<dynamic>)
            .map((item) => Store.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
      return response;
    } catch (e) {
      print('Error fetching stores: $e');
      return mockStoreData;
    }
  }

  // Example POST for creating a booking
  Future<Store?> bookStore(
      String storeId, Map<String, dynamic> bookingData) async {
    try {
      final response = await _sessionHandler.post<Store>(
        ApiUrl.bookStore(storeId),
        data: bookingData,
        fromJson: (data) => Store.fromJson(data as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      print('Error booking store: $e');
      return null;
    }
  }
}

final storeRepositoryProvider = Provider<StoreRepository>((ref) {
  final sessionHandler = ref.watch(sessionHandlerProvider);
  return StoreRepository(sessionHandler);
});
