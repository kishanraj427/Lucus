import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucus/notifier/storeNotifier.dart';
import 'package:lucus/screens/dashboard/storeCard.dart';
import 'package:lucus/components/bottomNavBar.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storesAsync = ref.watch(storesNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Hub - Book Now'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(storesNotifier.notifier).refresh(),
          ),
        ],
      ),
      body: storesAsync.when(
        data: (stores) => ListView.builder(
          itemCount: stores.length,
          itemBuilder: (context, index) {
            final store = stores[index];
            return StoreCard(
              store: store,
              onTap: () {
                // Navigate to store details/booking
                // context.go('/store/${store.id}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Booking ${store.name}...')),
                );
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              ElevatedButton(
                onPressed: () => ref.read(storesNotifier.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
