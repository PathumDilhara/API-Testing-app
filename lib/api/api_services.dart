import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class APIServices {
  // Fetch all data Product from the api https://fakestoreapi.com/products
  Future<List<ProductModel>> fetchAllProduct() async {
    const String url = "https://fakestoreapi.com/products";

    try {
      final response = await http.get(Uri.parse(url));
      //.get(Uri.parse(url))
      if (response.statusCode == 200) {
        List<dynamic> responseDataList = json.decode(response.body);
        List<ProductModel> productsList = responseDataList.map((json) {
          return ProductModel.fromJson(json);
        }).toList();

        return productsList;
      } else {
        print(
            "Failed to fetch product the status code : ${response.statusCode}");
        throw Exception("Isilda to fetch products");
      }
    } catch (err) {
      print("Error : $err");
      throw Exception("Failed to fetch product");
    }
  }

  // Fetch a single product from api
  Future<ProductModel> fetchSingleProduct(int id) async {
    final String url = "https://fakestoreapi.com/products/$id";

    try {
      final response = await http.get(Uri.parse(url));

      // checking data fetch successfully
      if (response.statusCode == 200) {
        ProductModel singleProduct =
            ProductModel.fromJson(json.decode(response.body));
        return singleProduct;
      } else {
        print(
            "Failed to fetch the product. Status code : ${response.statusCode}");
        throw Exception("Failed to fetch product");
      }
    } catch (err) {
      print("Error : $err");
      throw Exception("Failed to fetch product");
    }
  }

  // Add a product to the API
  Future<ProductModel> addProduct(ProductModel product) async {
    const String url = 'https://fakestoreapi.com/products';

    try {
      final response = await http.post(Uri.parse(url),
          // api are stateless then we have to pass all details that is a one reason use of header
          headers: {
            "Content-Type": "application/json"
          }, // which type of data we pass (json)
          body: json.encode(product.toJson()));

      print("Response Code : ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 200) {
        print("Response : ${response.body}");
        ProductModel newProduct =
            ProductModel.fromJson(json.decode(response.body));
        return newProduct;
      } else {
        print("Failed to add product. Status code : ${response.statusCode}");
        print("Response body : ${response.body}");
        throw Exception("Failed to add product");
      }
    } catch (err) {
      print("Error : $err");
      throw Exception("Failed to add product");
    }
  }

  // Updating a existing data in a API  using put request
  Future<ProductModel> updateProduct(int id, ProductModel product) async {
    final String url = "https://fakestoreapi.com/products/$id";

    // trying to update
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type" : "application/json"},
        body: json.encode(product.toJson()), // pass a map to convert into json
      );

      if(response.statusCode == 200){
        print("Response : ${response.body}");
        // using response.body inbuilt decoder will create json map then it will
        // pass into fromJson() to convert map into dart obj
        ProductModel updatedProduct  = ProductModel.fromJson(json.decode(response.body));
        return updatedProduct;
      } else {
        print("Failed to update the product. Status code : ${response.statusCode}");
        throw Exception("Failed to update the product");
      }
    } catch (err) {
      print("Error : $err");
      throw Exception("Failed to update the product");
    }
  }
}
