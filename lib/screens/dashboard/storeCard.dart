import 'package:flutter/material.dart';
import 'package:lucus/models/store.dart';

class StoreCard extends StatelessWidget {
  final Store store;
  final VoidCallback onTap;

  const StoreCard({
    super.key,
    required this.store,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
          store.imageUrl,
          width: 50,
          height: 50,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.store, size: 50),
          fit: BoxFit.cover,
        ),
        title: Text(store.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(store.description),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Text('${store.rating}'),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
