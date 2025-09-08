import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/store.dart';
import '../repositories/storeRepositories.dart';

class StoresNotifier extends AsyncNotifier<List<Store>> {
  @override
  Future<List<Store>> build() async {
    final storeRepository = ref.read(storeRepositoryProvider);
    return storeRepository.getStores();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }

  Future<void> bookStore(
      String storeId, Map<String, dynamic> bookingData) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final storeRepository = ref.read(storeRepositoryProvider);
      await storeRepository.bookStore(storeId, bookingData);
      return build(); // Refresh store list
    });
  }

  // Add methods like addStore, updateStore, etc., for other operations
}

final storesNotifier = AsyncNotifierProvider<StoresNotifier, List<Store>>(() {
  return StoresNotifier();
});
