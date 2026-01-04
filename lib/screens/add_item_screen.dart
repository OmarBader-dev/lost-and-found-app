import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  String status = 'Lost';

  void submitItem() async {
    await ApiService.addItem({
      "user_id": 1,
      "title": _titleController.text,
      "description": _descriptionController.text,
      "location": _locationController.text,
      "status": status,
      "key": "password"
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: _descriptionController, decoration: InputDecoration(labelText: 'Description')),
            TextField(controller: _locationController, decoration: InputDecoration(labelText: 'Location')),
            DropdownButton<String>(
              value: status,
              items: ['Lost', 'Found']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => status = val!),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: submitItem, child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}
