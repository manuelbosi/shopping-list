class Product {
  final int? id;
  final String name;
  final int listId;
  final bool isAdded;
  final String createdAt;

  Product({
    this.id,
    required this.name,
    required this.listId,
    required this.isAdded,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData == null) {
      throw Exception("Product json cannot be null");
    }
    return Product(
      id: jsonData['id'],
      name: jsonData['name'],
      listId: jsonData['list_id'],
      isAdded: jsonData['is_added'],
      createdAt: jsonData['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'list_id': listId,
      'is_added': isAdded,
      'created_at': createdAt,
    };
  }
}
