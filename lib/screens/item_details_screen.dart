import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/item.dart';
import '../services/api_service.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Item item;

  const ItemDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'http://lostandfouund.atwebpages.com/lostandfound_api/get_image.php?id=${item.id}',
              height: 220,
              width: double.infinity,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) {
                return Container(
                  height: 220,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 40),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('Status: ${item.status}'),
            const SizedBox(height: 10),
            Text('Location: ${item.location}'),
            const SizedBox(height: 10),
            Text(item.description),
            const Divider(height: 30),
            const Text(
              'Contact',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${item.name} • ${item.phone}'),
            const SizedBox(height: 30),
            if (item.status == 'Lost')
              ElevatedButton(
                onPressed: () async {
                  await ApiService.updateStatus(item.id, 'Found');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item marked as Found')),
                  );
                  Navigator.pop(context, true);
                },
                child: const Text('Mark as Found'),
              ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text('Upload Image'),
              onPressed: () async {
                final picker = ImagePicker();
                final picked =
                await picker.pickImage(source: ImageSource.gallery);
                if (picked == null) return;
                final imageFile = File(picked.path);
                await ApiService.uploadImage(item.id, imageFile);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Image uploaded')),
                );
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
