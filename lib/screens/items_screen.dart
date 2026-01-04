import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/api_service.dart';
import 'add_item_screen.dart';
import 'item_details_screen.dart';

class ItemsScreen extends StatefulWidget {
  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  late Future<List<Item>> _itemsFuture;
  String filter = 'All';

  @override
  void initState() {
    super.initState();
    _itemsFuture = ApiService.getItems();
  }

  void refreshItems() {
    setState(() {
      _itemsFuture = ApiService.getItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lost & Found'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                filter = value;
              });
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'All', child: Text('All')),
              PopupMenuItem(value: 'Lost', child: Text('Lost')),
              PopupMenuItem(value: 'Found', child: Text('Found')),
            ],
          )
        ],
      ),
      body: FutureBuilder<List<Item>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading items'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.search_off,
                      size: 60, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'No items found',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final filteredItems = snapshot.data!.where((item) {
            if (filter == 'All') return true;
            return item.status == filter;
          }).toList();

          return ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];

              return InkWell(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ItemDetailsScreen(item: item),
                    ),
                  );

                  if (result == true) {
                    refreshItems();
                  }
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 90,
                            height: 90,
                            color: Colors.grey[200],
                            child: Image.network(
                              'http://lostandfouund.atwebpages.com/lostandfound_api/get_image.php?id=${item.id}',
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) =>
                              const Icon(
                                  Icons.image_not_supported),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 14,
                                      color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      item.location,
                                      style: const TextStyle(
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4),
                                decoration: BoxDecoration(
                                  color: item.status == 'Lost'
                                      ? Colors.red
                                      .withOpacity(0.15)
                                      : Colors.green
                                      .withOpacity(0.15),
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),
                                child: Text(
                                  item.status,
                                  style: TextStyle(
                                    color:
                                    item.status == 'Lost'
                                        ? Colors.red
                                        : Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddItemScreen()),
          );

          if (result == true) {
            refreshItems();
          }
        },
      ),
    );
  }
}
