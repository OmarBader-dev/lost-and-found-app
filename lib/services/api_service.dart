import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/item.dart';

class ApiService {
  static const String baseUrl =
      'http://lostandfouund.atwebpages.com/lostandfound_api';

  static Future<List<Item>> getItems() async {
    final response =
    await http.get(Uri.parse('$baseUrl/get_items.php'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Item.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  static Future<int> addItem(Map<String, dynamic> data) async {
    data['key'] = 'password';

    final response = await http.post(
      Uri.parse('$baseUrl/add_item.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    final decoded = json.decode(response.body);

    if (decoded['success'] == true) {
      return decoded['item_id'];
    } else {
      throw Exception(decoded['message'] ?? 'Failed to add item');
    }
  }

  static Future<void> updateStatus(int id, String status) async {
    await http.post(
      Uri.parse('$baseUrl/update_status.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "id": id,
        "status": status,
        "key": "admin"
      }),
    );
  }

  static Future<void> uploadImage(int itemId, File image) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/upload_image.php'),
    );

    request.fields['item_id'] = itemId.toString();
    request.files.add(
      await http.MultipartFile.fromPath('image', image.path),
    );

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Image upload failed');
    }
  }
}
