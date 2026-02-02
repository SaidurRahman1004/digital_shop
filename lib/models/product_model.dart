class Product {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final String? validity; // Nullable
  final String? description;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    this.validity,
    this.description,
  });
}
