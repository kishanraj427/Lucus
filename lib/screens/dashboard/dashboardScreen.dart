import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucus/notifier/storeNotifier.dart';
import 'package:lucus/screens/dashboard/locationWidget.dart';
import 'package:lucus/screens/dashboard/storeCard.dart';
import 'package:lucus/utility/appColor.dart';
import 'package:lucus/utility/appSize.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storesAsync = ref.watch(storesNotifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lucus",
          style: GoogleFonts.aboreto(
              fontSize: AppSize.iconSize,
              fontWeight: FontWeight.bold,
              color: AppColors.primary600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(storesNotifier.notifier).refresh(),
          ),
        ],
      ),
      body: storesAsync.when(
        data: (stores) => Column(
          children: [
            const LocationWidget(),
            Expanded(
              child: ListView.builder(
                itemCount: stores.length,
                itemBuilder: (context, index) {
                  final store = stores[index];
                  return StoreCard(
                    store: store,
                    onBook: () {
                      // Navigate to store details/booking
                      // context.go('/store/${store.id}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Booking ${store.name}...')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
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
    );
  }
}
