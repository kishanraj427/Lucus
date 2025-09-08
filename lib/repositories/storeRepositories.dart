import '../models/store.dart';

class StoreRepository {
  Future<List<Store>> getStores() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    // Mock data
    return [
      const Store(
        id: '1',
        name: 'Electronics Store',
        description: 'Your one-stop shop for gadgets.',
        imageUrl: 'https://example.com/electronics.jpg',
        rating: 4.5,
      ),
      const Store(
        id: '2',
        name: 'Fashion Hub',
        description: 'Latest trends in clothing.',
        imageUrl: 'https://example.com/fashion.jpg',
        rating: 4.2,
      ),
    ];
  }
}
