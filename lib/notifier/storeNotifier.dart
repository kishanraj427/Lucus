import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/store.dart';
import '../repositories/storeRepositories.dart';

final storeRepositoryProvider = Provider<StoreRepository>((ref) {
  return StoreRepository();
});

class StoresNotifier extends AsyncNotifier<List<Store>> {
  @override
  Future<List<Store>> build() async {
    final repository = ref.read(storeRepositoryProvider);
    return repository.getStores();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }

  // Add methods like addStore, updateStore, etc., for other operations
}

final storesNotifier = AsyncNotifierProvider<StoresNotifier, List<Store>>(() {
  return StoresNotifier();
});
