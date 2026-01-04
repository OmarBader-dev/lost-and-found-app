import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/api_service.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Item item;

  ItemDetailsScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    final nextStatus =
    item.status == 'Lost' ? 'Found' : 'Lost';

    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.title,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Status: ${item.status}'),
            SizedBox(height: 10),
            Text('Location: ${item.location}'),
            SizedBox(height: 10),
            Text(item.description),
            Divider(height: 30),
            Text('Contact',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('${item.name} • ${item.phone}'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await ApiService.updateStatus(
                    item.id, nextStatus);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                      Text('Status updated to $nextStatus')),
                );

                Navigator.pop(context);
              },
              child: Text('Mark as $nextStatus'),
            ),
          ],
        ),
      ),
    );
  }
}
