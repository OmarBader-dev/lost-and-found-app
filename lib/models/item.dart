class Item {
  final String title;
  final String description;
  final String location;
  final String status;
  final String name;
  final String phone;

  Item({
    required this.title,
    required this.description,
    required this.location,
    required this.status,
    required this.name,
    required this.phone,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'],
      description: json['description'],
      location: json['location'],
      status: json['status'],
      name: json['name'],
      phone: json['phone'],
    );
  }
}
