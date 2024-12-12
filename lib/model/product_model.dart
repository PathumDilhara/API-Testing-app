class ProductModel {
  final int? id;
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;

  ProductModel({
    this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  // Factory method for convert json into dart object named Product model
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        image: json["image"],
        category: json["category"]);
  }

  // Method convert dart product model obj to json
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "price": price,
      "description" : description,
      "image": image,
      "category": category,
    };
  }
}
