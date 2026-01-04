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
  late Future<List<Item>> itemsFuture;
  String filter = 'All';

  @override
  void initState() {
    super.initState();
    itemsFuture = ApiService.getItems();
  }

  void refreshItems() {
    setState(() {
      itemsFuture = ApiService.getItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lost & Found'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                filter = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'All', child: Text('All')),
              PopupMenuItem(value: 'Lost', child: Text('Lost')),
              PopupMenuItem(value: 'Found', child: Text('Found')),
            ],
          )
        ],
      ),
      body: FutureBuilder<List<Item>>(
        future: itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading items'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items found'));
          }

          final items = snapshot.data!;
          final filteredItems = items.where((item) {
            if (filter == 'All') return true;
            return item.status == filter;
          }).toList();

          return ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              return Card(
                child: ListTile(
                  title: Text(item.title),
                  subtitle:
                  Text('${item.location} • ${item.status}'),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ItemDetailsScreen(item: item),
                      ),
                    );
                    refreshItems();
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddItemScreen(),
            ),
          );
          refreshItems();
        },
      ),
    );
  }
}
