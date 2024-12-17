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

  // This method does the reverse: it converts a JSON Map (received from an API
  // or database) into a ProductModel object.
  // Always pass a map that created by inbuilt json.encode method
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        image: json["image"],
        category: json["category"]);
  }

  // If you have a custom Dart class (like your ProductModel), json.encode()
  // does not know how to encode it into JSON because it doesn't automatically
  // understand the structure of your class.
  //
  // This is why you need a method like toJson() that converts your Dart object
  // into a Map that json.encode() does understand.

  // This method converts a ProductModel Dart object into a Map (which can be
  // encoded to JSON).
  //
  // Here’s what happens:
  //
  // When you call product.toJson(), it creates a Map<String, dynamic> object.
  // This map can be passed to json.encode() to turn it into a JSON string.

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
