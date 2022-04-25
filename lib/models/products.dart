class Product {
  final int id;
  final String name;
  final int listId;
  final bool isAdded;

  Product({
    required this.id,
    required this.name,
    required this.listId,
    required this.isAdded,
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
    );
  }
}
