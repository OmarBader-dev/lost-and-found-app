import 'dart:convert';
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

  static Future<void> addItem(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_item.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception('Failed to add item');
    }
  }


}
